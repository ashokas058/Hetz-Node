pipeline{
    agent any

    stages{

    stage("init"){

        steps{
            printf "\$(pwd)"
            printf "changed jenkins workdir:- \$(pwd)"
        }
    }
    stage("Docker-Build"){
        steps{
            sh "sudo docker build -t hetzserver:1.1 ."
            printf "\$(sudo docker images ls|head -2)\n"
        }
    }
    stage("Listing All Images"){
        steps{
            printf "\$( sudo docker images ls )\n"  
        }
    }
    stage("Deploy"){
        steps{
          
            sh "sudo docker run -d -p 3000:3000 hetzserver:1.1"

        }
    }
    
}
post{
    success{
        sh "docker logs \$(docker ps | head -2|tail -1|awk ' {print \$1} ')"
    }
}

}



