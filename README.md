# Terraform
# Home tasks from courses

#### Встановлюємо на Linux у терміналі Terraform із сайту 
#### https://www.terraform.io/
#### https://developer.hashicorp.com/terraform/install?product_intent=terraform

##### wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
##### echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
##### sudo apt update && sudo apt install terraform

#### вводимо пароль для su (super user-a)

##### cd /bin 
##### ls | grep terraform
##### cd ..
##### terraform --version

##### clear 
#### Тепер встановлюємо Visual Studio Code із сайту 
#### https://code.visualstudio.com/download 
#### скачуємо Linux Ubuntu .deb
#### Далі відкриваємо з термінала

##### cd /home/diana/Downloads
##### ls
##### sudo dpkg -i *назва файлу, наприклад, code_1.84.2-1699528352_amd64.deb*
#### відкриваємо VS Code
##### code
