#!/bin/bash

export TERM=xterm

cd /usr/local/bin/

echo "installing git"
sudo apt install git -y

echo "cloning mycroft-core"
sudo git clone https://github.com/MycroftAI/mycroft-core.git


echo "entering mycroft-core directory"
cd ./mycroft-core


echo "automating answers to options"
sed -i '227,265s/if get_YN ;/if false ;/g' ./dev_setup.sh 
sed -i '277,329s/if get_YN ;/if true ;/g' ./dev_setup.sh 


echo "running dev_setup"
./dev_setup.sh 


echo "installing pip"
pip install --upgrade pip


echo "running dev_setup skipping mimic build"
./dev_setup.sh -sm



echo "entering skills directory"
cd ./mycroft-core/skills

echo "cloning all the skills"
#adding chatgpt
git clone https://github.com/marwiieee/mycroft-chatgpt-fallback.git

#adding lonely skill
git clone https://github.com/adamkalbouneh/lonely-skill-skill.git

# adding jokes skill
git clone https://github.com/adamkalbouneh/joke-skill.git

#adding affirmations skill
git clone https://github.com/adamkalbouneh/affirmations-skill.git

#adding good morning skill
git clone https://github.com/adamkalbouneh/good-morning-skill.git

#adding compliment skill
git clone https://github.com/adamkalbouneh/compliment-me-skill.git

#adding happy skill
git clone https://github.com/adamkalbouneh/happy-skill.git

#adding bored skill
git clone https://github.com/adamkalbouneh/bored-skill.git

#adding i love you skill
git clone https://github.com/adamkalbouneh/i-love-you-skill.git

#adding sad skill
git clone https://github.com/adamkalbouneh/sad-skill.git

#adding radio 
git clone https://github.com/johnbartkiw/mycroft-skill-tunein.git


echo "exiting skills directory"
cd ..

echo "starting speaker"
bash start-mycroft.sh debug