#!/bin/bash

# configura las variables principales de github
# esto en conjunto con las llaves son las que permiten el acceso
Git_global_config () {
    read -p "Ingresa tu nombre de usuario en github recuerda que distingue entre masyusculas y minisculas: " usuario
    git config --global user.name "$usuario"
    read -p "Ingresa tu correo electronico con el que accedes a github: " mail
    git config --global user.email "$mail"
}

#funcion que nos permite generar una llave publica/ privada
# Que github accepta para acceder.
ssh_key_generator(){
    echo "Ahora procedermos a crear las llaves publicas y privadas"
    read -p "Ingresa tu correo electronico con el que accedes a github: " mail2
    echo "*** EN ESTE PASO TE ACONSEJO DAR ENTER UNICAMENTE Y NO RELLENAR ***"
    echo "*** EN CASO DE PREGUNTAR SI DESEAS SOBRE ESCRIBIR TECLEA Y ***"
    ssh-keygen -t rsa -b 4096 -C "$mail2"
    ssh-agent -s
    chmod 600 $HOME/.ssh/id_rsa
    chmod 600 $HOME/.ssh/id_rsa.pub
    ssh-add $HOME/.ssh/id_rsa
    echo "Ahora deberas agregar la llave publica guardada en $HOME/.ssh/id_rsa.pub"
    echo "igualmente te generare un documento de texto en $HOME/Desktop/Llave_publica.txt"
    cat $HOME/.ssh/id_rsa.pub > $HOME/Desktop/Llave_publica.txt
}

{ #try
    
    #Variables de decision es un coñazo que compare string puros
    # asi que decidi crear una para si (Y) y otra para no (N)
    Correct="Y"
    Incorrect="N"
    if sudo apt-get install git -y > /dev/null 2>&1; then
        
        read -p "El software ya se encuentra instalado, desea modificarlo el git-global (Y/N): " global
        
        if  [ ${global^^} = "$Correct" ]; then
            Git_global_config
            clear
            elif [ ${global^^} = "$Incorrect" ]; then
            echo "Vale se da por hecho que ya las has configurado."
        fi
        
        read -p "Desea crear las llaves SSH ¿Desea hacerlo? (Y/N): " ssh_dec
        
        if [ ${ssh_dec^^} = "$Correct" ]; then
            clear
            ssh_key_generator
            elif [ ${ssh_dec^^} = "$Incorrect" ]; then
            echo "Vale se da por hecho que ya las has creado tu."
            exit
        fi
    else
        
        read -p "El software de git no se encuentra Instalado ¿Desea instalarlo?(Y/N): " des2
        
        if  [ ${des2^^} = "$Correct" ]; then
            sudo apt-get install git -y
            clear
            
            read -p "El software se ha instalado correctamente, ¿desea configurar git-global? (Y/N)" dec3
            
            if [ ${dec3^^} = "$Correct" ]; then
                echo "Empezaremos ahora a configurar el git-global"
                Git_global_config
                
                elif [ ${dec3^^} = "$Incorrect" ]; then
                echo "Vale hemos de suponer que deseas hacerlo manualmente"
                continue
            fi
            
            read -p "¿desea crear las llaves SSH? (Y/N) para tu github" dec4
            
            if [ ${dec4^^} = "$Correct" ]; then
                echo "Empezaremos con el proceso de configuracion, \n asegurate de leer bien las instrucciones"
                ssh_key_generator
                elif [ ${dec4^^} = "$Incorrect" ]; then
                echo "Ha decidido no hacerlo pero es recomendado para poder conectar por SSH a su git"
                exit
                
            fi
            
            elif [ ${des2^^} = "$Incorrect" ]; then
            echo "Haz decidido no instalarlo, ten un un buen dia"
            exit
        fi
    fi
    } || { # catch
    echo "Parece que algo ha surgido mal, intentalo de nuevo"
    exit
}