# Administração {#admin}

## Tipos de Contas

- root
- Sistema
- Normal
- Rede

Para um ambiente de trabalho seguro é recomendado proporcionar o mínimo possível de privilégios para as contas e remover contas inativas.
O comando `last` lista a última vez que cada usuário entrou no sistema.

## Conta `root`
Não há restrições de seguranças impostas para a conta `root`.
Os previlégios de `root` são necessários para:

- Criar, remover e gerenciar contas de usuários
- Gerenciar pacotes de *software*
- Remover ou modificar arquivos do sistema
- Reiniciar serviços do sistema

## Criar novo usuário

    sudo useradd <usuario>
    sudo passwd <usuario>

## Adicionar usuário a um grupo de usuários que já existe

    sudo usermod -a -G <groupo> <usuario>

## Listar usuários cadastrados

    cat /etc/passwd | grep 1[0-9][0-9][0-9]

Não é necessário sudo. Todos os usuarios comuns do sistema possuem UID >= 1000.

## Bloquear usuário

O comando a seguir impede que determinado usuário acesse o sistema.

    sudo passwd <usuario> -l
    
Para reativar o usuário.

    sudo passwd <usuario> -u
    
## Remover usuário
Para remover um usuário do sistema sem remover o diretório pessoal e outros dados relacionados.

    sudo userdel <usuario>

Para remover o usuário, seu diretório pessoal e todas as informações relacionadas.

    sudo userdel <usuario> -r

## Operações que não requerem root

* Executar um cliente de rede
* Usar dispositivos como impressora
* Operações em arquivos que o usuário tem permissões apropriadas
* Executar aplicações como `passwd`

## `su` vs `sudo`
* `su` Quando avaliado, é necessário entrar com a senha de `root`. Jamais deve dar a senha de `root` para um usuário normal.|Quando avaliado, é necessário entrar com a senha de usuário. O comando tem *logging* limitado.
* `sudo` Após ser avaliado como `root` usando `su`, o usuário consegue fazer qualquer coisa que o `root` pode fazer pelo tempo que desejar sem ser pedido por uma senha novamente.|Oferece mais opções e é considerado mais seguro e mais configurável. O que o usuário pode fazer pode ser controlado e limitado. Por padrão, o usuário terá que informar a senha em todas as operações com o comando `sudo`. O comando tem *logging* detalhado.

### sudo
* arquivo `/etc/sudoers` e diretório `/etc/sudoers.d/` mantém as informações de configuração e autorização.
* o arquivo de `/var/log/secure` (ou `/var/log/messages`, na família **Debian** é `/var/log/auth.log`) registra as tentativas de *login* e *sudo* que falharam.

### Arquivo `sudoers`
O arquivo `sudoers` pode ser editado usando o comando `visudo`.
A estrutura básica é:

    quem onde = (como:quem) o_que

Em alguns sistemas é utilizado o diretório `sudoers.d` com um arquivo para cada usuário.

### *logging* do comando
Informações gravadas a cada tentativa de usar `sudo`:
* Nome do usuário
* Informações de terminal
* Diretório de trabalho
* Conta de usuário invocada
* Comando com argumentos

## Logs

*Como verificar se o computador foi desligado corretamente*

Executar o comando:

    last -x | less

Deve haver três entradas nesse arquivo, na ordem:

    runlevel
    reboot
    shutdown
    runlevel

Significa que o computador foi desligado e posteriormente religado.
Se houver apenas a linha `reboot` significa que o computador não foi desligado corretamente.
Os registros de *login* também são indicadores de desligamento.
Exemplos de registros, primeiro o computador foi desligado corretamente:

    welliton pts/0        :0               Tue Feb 10 08:58   still logged in   
    welliton tty7         :0               Tue Feb 10 08:58   still logged in   
    (unknown tty7         :0               Tue Feb 10 08:58 - 08:58  (00:00)    
    runlevel (to lvl 2)   3.2.0-4-amd64    Tue Feb 10 08:58 - 09:09  (00:11)    
    reboot   system boot  3.2.0-4-amd64    Tue Feb 10 08:58 - 09:09  (00:11)    
    shutdown system down  3.2.0-4-amd64    Tue Feb 10 08:57 - 08:58  (00:00)    
    runlevel (to lvl 0)   3.2.0-4-amd64    Tue Feb 10 08:57 - 08:57  (00:00)    
    welliton pts/0        :0               Tue Feb 10 08:52 - down   (00:04)    
    welliton tty7         :0               Tue Feb 10 08:50 - down   (00:06)

`down` significa que o usuário estava logado quando o computador foi desligado corretamente.
`(unknown` é o ambiente gráfico, servidor X.
Outro exemplo, dessa vez um registro de desligamento por queda de energia:

    (unknown tty7         :0               Tue Feb 10 08:49 - 08:50  (00:01)    
    runlevel (to lvl 2)   3.2.0-4-amd64    Tue Feb 10 08:48 - 08:57  (00:08)    
    reboot   system boot  3.2.0-4-amd64    Tue Feb 10 08:48 - 08:57  (00:08)    
    (unknown tty10        :1               Mon Feb  9 16:18 - crash  (16:30)
  
`crash` indica que o usuário estava logado quando o computador foi desligado incorretamente.

As informações exibidas pelo programa `last` ficam armazenadas no arquivo binário `/var/log/wtmp`.

## Agendar Desligamento do Sistema

As vezes é necessário desligar os computadores antes de um horário específico para depois serem ligados novamente após uma manutenção no sistema de energia do prédio. Podemos agendar o desligamento do sistema utilizando o comando `shutdown`. Um exemplo:

    sudo shutdown -h 06:00 "Manutencao gerador energia e atualizacao sistema" &

O comando vai agendar o deligamento do sistema para às 6 horas da manhã. Se o comando for executado após o horário então a ação será executada no dia seguinte. Altere o argumento `-h` para `-r` e o sistema vai reiniciar ao invés de deligar. O texto em aspas aparecerá para os usuários logados no sistema no momento que o comando for executado. No sistema Ubuntu é recomendado deixar a execução do comando em segundo plano, principalmente se executado em uma sessão SSH. Se for utilizar o comando `sudo` precisa tomar cuidado com a solicitação de senha, se aparecer uma mensagem dizendo que o processo está parado execute o comando `fg` e digite a senha do usuário.

Qualquer usuário com poderes administrativos pode cancelar o agendamento. Para cancelar execute:

    sudo shutdown -c

Há outras formas de manter esse comando em segundo plano como o programa `screen` e também é possível agendar o deligamento do sistema pelo `cron`.

## Listar usuários e processos ativos

Antes de realizar qualquer manutenção em um sistema multiusuário é importante verificar se não há processos de usuários ativos. Atualizar ou reniciar o sistema pode prejudicar os processos em execução.

Listar usuários logados

    who

Embora um usuário pode não estar logado, ele pode ter processos ativos, dentro de uma sessão SCREEN por exemplo. Listar todos os processos ativos exceto os processos do usuário root (do sistema)

    ps aux | grep -v ^root

## Atualizar sistema

Atualizar listagem de pacotes

    sudo apt-get update
    
Atualizar pacotes

    sudo apt-get upgrade

Listar pacotes que exigem que o sistema seja reinicializado após atualização

    cat /var/run/reboot-required.pkgs
