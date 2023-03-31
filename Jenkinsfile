pipeline{
    agen any

    stages{

    stage("init"){

        step{
            printf "\$(pwd)"
            cd /var/lib/jenkins/Hetz-NodeServer
            printf "changed jenkins workdir:- \$(pwd)"
        }
    }
    stage("Docker-Build"){
        step{
            sh "sudo docker build -t hetzserver:1.0 ."
            printf "\$(sudo docker images ls|head -2)\n"
        }
    }
    stage("Listing All Images"){
        step{
            printf "\$(sudo docker images ls)\n"  
        }
    }
    stage("Deploy"){
        step{
           sh " sudo fuser -k 80/tcp"
            sh "sudo docker run -d -p 80:3000 hetzserver:1.0"

        }
    }
    
}
post{
    success{
        sh "docker logs \$(docker ps | head -2|tail -1|awk ' {print \$1} ')"
    }
}
}



