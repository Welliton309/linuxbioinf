# Dicas {#tips}

## Instalando fontes do Microsoft Windows

O sistema operacional GNU/Linux não vem com as fontes mais conhecidas (como Arial, Times New Roman, Tahoma, etc.) porque essas fontes são proprietárias. É possível instalar essas fontdes de duas formas (distribuição Ubuntu). A mais fácil é instalar o pacote de sistema `ttf-mscorefonts-installer`.

    sudo apt-get install ttf-mscorefonts-installer

O pacote baixa da Internet e instala as principais fontes da Microsoft.

Outra forma é instalar, manualmente, as fontes a partir de uma instalação Windows. Esse processo fica mais fácil quando o sistema da Microsoft está intalado em *dual-boot* com o Linux. Para fazer isso, basta 1) copiar a pasta `C:\Windows\Fonts` da partição do Windows para o diretório *home* do usuário, 2) renomear o diretório `~/Fonts` para `~/.fonts` e 3) executar o comando que atualiza o *cache* de fontes.

    sudo fc-cache -fv
  
Para testar a instalação das fontes basta iniciar o programa LibreOffice ou sismilar e verificar se as novas fontes aparecem na caixa de seleção de fontes.
