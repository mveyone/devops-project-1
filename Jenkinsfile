node{
    
    stage('git checkout'){
       git branch: 'main', credentialsId: 'github', url: 'https://github.com/mveyone/devops-project-1.git'
    }
    stage('sending dockerfile to ansible server'){
        sshagent(['ansible_demo']) {
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174 '
         sh 'scp /var/lib/jenkins/workspace/devops-aws/* ubuntu@172.31.91.174:/home/ubuntu '
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174  unzip -o devops-project-1.zip '
      }
    }
     stage('build docker image'){
        sshagent(['ansible_demo']) {
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174 cd /home/ubuntu '
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174 docker build -t $JOB_NAME:v1.$BUILD_ID . '
         //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174 ansible-playbook docker-playbook.yml'
      }
    }
    stage('image tagging '){
        sshagent(['ansible_demo']) {
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174 docker image tag $JOB_NAME:v1.$BUILD_ID mveyone/$JOB_NAME:v1.$BUILD_ID '
         sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174 docker image tag $JOB_NAME:v1.$BUILD_ID mveyone/$JOB_NAME:latest '
      }
    }
    stage('Push docker image to docker hub'){
        sshagent(['ansible_demo']) {
            //withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'dockerhub-pass')]) {
               //sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174  docker login -u mveyone -p ${dockerhub-pass}"
               sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174  docker image push mveyone/$JOB_NAME:v1.$BUILD_ID'
               sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174  docker image push mveyone/$JOB_NAME:latest '
               sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.91.174  docker image rm mveyone/$JOB_NAME:latest  mveyone/$JOB_NAME:v1.$BUILD_ID $JOB_NAME:v1.$BUILD_ID'
        
            }
        //}
    }
    stage('copy files from ansible to kubernetes server'){
        sshagent(['ansible_demo']){
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.16.130'
                sh 'scp /var/lib/jenkins/workspace/devops-aws/*  ubuntu@172.31.16.130:/home/ubuntu'   
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.16.130  unzip -o devops-project-1.zip '
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.16.130 ansible-playbook k8s/k8s-playbook.yml'   
             }
    }
}