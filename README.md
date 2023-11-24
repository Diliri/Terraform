# Terraform
## Home tasks from courses  
Встановлюємо на Linux у терміналі [Terraform](https://www.terraform.io/) або з цього [сайту](https://developer.hashicorp.com/terraform/install?product_intent=terraform)

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
вводимо пароль для su (super user-a)
```
cd /bin 
ls | grep terraform
cd ..
terraform --version

clear
``` 
Тепер встановлюємо [Visual Studio Code](https://code.visualstudio.com/download), скачуємо Linux Ubuntu .deb  
Далі відкриваємо з термінала
```cd /home/diana/Downloads
ls
sudo dpkg -i *назва файлу, наприклад, code_1.84.2-1699528352_amd64.deb*
```
відкриваємо VS Code  
```code```
відкриваємо термінал
```cd ../../..
mkdir my-terraform
```

відкриваємо цю папку у VS Code, попередньо встановивши необхідні плагіни (terraform , наприклад)
створюємо файл lesson-1.tf


Пишемо у терміналі:
```
# version 1.15.58
# sudo snap install aws-cli

# version 1.22.34-1
sudo apt install awscli -y
# вводимо пароль

aws configure
# вводимо AWS Access Key ID
# для цього заходимо на AWS account IAM > Users > Diana_Muzhylivska > Security Credentials (вгорі справа) > Create Access Key > Use Case "Command Line Interface (CLI)
# галочка біля "I understand the above reccomendation..."
# Description Tag Value "demo-aws-cli"
```
