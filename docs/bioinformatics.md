# Bioinformática {#bioinf}



Nesse capítulo é apresentado como instalar programas de Bioinformática.

## Instalar ambiente estatístico R

As distribuições Ubuntu e Debian possuem o programa R pronto para ser instalado via Internet usando o gerenciador de pacotes `apt-get` (ou `aptitude`), entretanto a versão do programa R disponível é desatualizada.
Para obter a versão mais atual do programa R é preciso adicionar a fonte de pacotes do CRAN usando algum _mirror_ oficial e editar o arquivo de configuração do sistema localizado em `/etc/apt/sources.list`.
  
Adicionar a fonte de pacotes, nesse caso é utilizado o _mirror_ oficial da [FMVZ USP](http://www.vps.fmvz.usp.br/CRAN/).
A lista de mirrors oficials esta disponível [aqui](http://cran.r-project.org/mirrors.html).
O texto a segir deve ser adicionado no final do arquivo `/etc/apt/sources.list`.

    # R repositories - lasted package versions
    deb http://www.vps.fmvz.usp.br/CRAN/bin/linux/ubuntu xenial/
  
Após salvar as alterações no arquivo é necessário atualizar a lista de pacotes do gerenciador.


```bash
sudo apt-get update
```
  
Haverá um aviso sobre a identidade da nova fonte de pacotes, para resolver é necessário fazer a autenticação. Esse passo é opcional.


```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
```

Pronto. Agora instalar o programa R e suas dependências.


```bash
sudo apt-get install r-base-dev
```

É recomendado instalar os pacotes do R dentro do ambiente usando a função `install.packages` pois eles estão mais atualizados.
Fazer isso como usuário comum, assim os pacotes instalados ficam no diretório pessoal do usuário e não interfere na administração do sistema.

## Instalar RStudio Server

Passo a passo para instalação do programa estatístico _R_ e o progrma _RStudio_ versão servidor. O _RStudio Server_ é executado no sistema operacional como um serviço, sua IDE (interface de desenvolvimento integrado) é acessado a partir do navegador Web, todo o processamento é executado na maquina servidora. A autenticação da IDE é feita utilizando informações de usuários de sistema, vários usuários podem utilizar o ambiente de desenvolvimento simultaneamente.

Essa configuração é recomendada para ambientes multiusuários onde os computadores Desktop não possuem recurso computacional (processador, memória RAM e disco) suficiente para executar as análises em R. Também existe a versão Desktop do _Rstudio_, mais informações no [site oficial](http://www.rstudio.com/products/RStudio/).

O tutorial foi testado no sistema operacional _Ubuntu Server 14.04.1_ disponível para [Download](http://www.ubuntu.com/download/server).

Primeiro resolver uma dependencia do sistema.

    sudo apt-get install libapparmor1 libssl0.9.8
  
Depois baixar o arquivo `.deb` e instalar.


```bash
wget https://download2.rstudio.org/rstudio-server-1.0.136-amd64.deb
sudo dpkg -i rstudio-server-1.0.136-amd64.deb
```

É recomendado acessar o site oficial e baixar a versão mais atual do programa encontrado [aqui](http://www.rstudio.com/products/rstudio/download-server/). Para acessar a IDE pelo navegador acesse o IP da maquina, porta 8787.

## Pacotes extras (opcional)

Alguns pacotes do sistema poderão ser necessários ao trabalhar com determinados pacotes do R.


```bash
sudo apt-get install libcurl4-openssl-dev ghostscript libxml2-dev
```

Para gerar arquivos PDF de documento R Markdown e Sweave é preciso instalar o _TeX Live_ no sistema, isso exige espaço em disco considerável.


```bash
sudo apt-get install texlive texlive-latex-extra texlive-fonts-extra texinfo
```

Para concluir instalar o git.
O Rstudio tem integração com programas de versionamento de códigos.


```bash
sudo apt-get install git
```

## Instalar R a partir do código fonte

A versão recomendada do R para utilização é a versão estável mais atual. Entretanto, quando a tarefa é desenvolver e testar novos pacotes para o R/Bioconductor é importante utilizar a última versão do R lançada. Essa versão pode ser considerada instável e por isso imprópria para ambientes de produção. Dessa forma, este tutorial ensina a instalar a última versão do R a partir do código fonte, mas sem alterar a versão do R instalada no sistema operacional. Sempre que lançado uma nova versão do R é importante atualizar o programa antes de testar os pacotes em desenvolvimento. Para ter a versão mais atual do R é necessário baixar e compilar o código fonte manualmente.

Instalar pacotes do sistema para compilar códigos fonte. O pacote `xorg-dev` é opcional mas recomendado.


```bash
sudo apt-get install build-essential gfortran libreadline6-dev openjdk-7-jdk libcurl4-gnutls-dev libpcre3-dev libbz2-dev xorg-dev
```

*LaTeX* é uma coleção de programas compiladores e arquivos de fontes de texto para criação de documentos com alta resolução. Os vignettes e manuais de pacotes R/Bioconductor são criados a partir do uso do LaTeX em conjunto com outras ferramentas próprias como Sweave e knitr. Dessa forma é importante ter os pacotes do LaTeX instalados na máquina de desenvolvimento, entretanto ocupa muito espeço em disco. A instalação do LaTeX é opcional, mas é necessário para gerar a documentação em HTML e PDF, inclusive os *vignettes*. Para instalar nos sistemas Ubuntu e Debian:

Baixar a versão mais atual do R.


```bash
wget https://cran.r-project.org/src/base-prerelease/R-latest.tar.gz
```

Extrair e acessar diretório.


```bash
tar -xf R-latest.tar.gz
cd R-beta/
```

Configurar ambiente e parâmetros de compilação.


```bash
./configure
```

A saída do script `configure` é importante também para verificar se o sistema operacional atende as dependências do R. Abaixo o resumo do script após executado.

```
R is now configured for x86_64-pc-linux-gnu

  Source directory:          .
  Installation directory:    /usr/local

  C compiler:                gcc  -g -O2
  Fortran 77 compiler:       f95  -g -O2

  C++ compiler:              g++  -g -O2
  C++11 compiler:            g++  -std=c++11 -g -O2
  Fortran 90/95 compiler:    gfortran -g -O2
  Obj-C compiler:	      

  Interfaces supported:      X11
  External libraries:        readline, curl
  Additional capabilities:   PNG, NLS
  Options enabled:           shared BLAS, R profiling

  Capabilities skipped:      JPEG, TIFF, cairo, ICU
  Options not enabled:       memory profiling

  Recommended packages:      yes
 ```
 
Na listagem acima é possível observar que os compiladores que serão utilizado são GNU (gcc, g++ e gfortran). Também mostra que o programa suportará interface gráfica (X11) e diversos tipos de formatos de imagem (PNG, JPEG, etc).

O próximo passo é compilar o programa (isso pode levar um tempo considerável).


```bash
make
```

Para executar o R.


```bash
bin/R
```
    
Versão do R


```bash
bin/R --version
```

```
R version 3.3.0 beta (2016-03-30 r70404) -- "Supposedly Educational"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
http://www.gnu.org/licenses/.
```
    
(Opcional) Como listado na saída do script `configure`, é configurado um diretório no sistema para instalar o R para todos os usuários (no exemplo o diretório `/usr/local). Isso pode atrapalhar o R previamente intalado. Para instalar o R no sistema.


```bash
sudo make install
```
