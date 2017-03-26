# Navegando pelo sistema {#commands}



Ao abrir o programa terminal de linha de comando nós somos recebidos com uma tela em branco com apena uma linha de texto parecida com essa:

```
welliton@desk3:~$
```

Para muitos essa única linha é intimidadora pois não dá nenhuma pista do que fazer a seguir. Essa linha chamada de _prompt_ (porque espera em prontidão por comandos) possui três informações importantes:

`welliton` é o usuário atual. Cada usuário verá o seu próprio nome.
`desk3` é o nome do computador que é definido durante a instalação do sistema operacional. O `@` (arroba) lê-se _at_ (em inglês) que significa __em__ no sentido de lugar.
O `:` (dois pontos) separa o nome do usuário do __diretório de trabalho__. O diretório de trabalho é o lugar, na estrutura de diretórios do sistema operacional, que o prompt  de comando __está__ atualmente. O diretório atual. O `~` (til) é um caractere curinga que significa __diretório pessoal do usuário atual__. Cada usuário tem seu próprio usuário pessoal  chamado de diretório home (lar em inglês).

A linha `welliton@desk3:~$` pode ser lida da seguinte forma: o usuário do sistema `welliton` está conectado ao computador chamado de `desk3` e seu diretório de trabalho é home. Mas onde, exatamente, eu estou?

<div class="figure">
<!--html_preserve--><div id="htmlwidget-aba6e0e9068a5355bb39" style="width:96px;height:96px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-aba6e0e9068a5355bb39">{"x":{"diagram":"digraph start {\n\ngraph []\n\nnode [shape = circle,\n      color = red,\n      width = 0.9]\n\".\"\n\n\".\"\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:unnamed-chunk-2)Ainda não sabemos em que lugar do sistema de arquivos nós estamos.</p>
</div>

O comando `pwd` (de _**p**rint **w**orking **d**irectory_) imprime o caminho absoluto da localização do diretório atual.


```bash
pwd
```

```
/home/welliton
```

<div class="figure">
<!--html_preserve--><div id="htmlwidget-cd76127ea218cbb71dfa" style="width:96px;height:288px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-cd76127ea218cbb71dfa">{"x":{"diagram":"digraph start {\n\ngraph []\n\nnode [shape = circle,\n      width = 0.9]\n\"/\" home\n\nnode [color = red]\nwelliton\n\n\"/\" -> home -> welliton [ dir = none ]\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:unnamed-chunk-4)Agora nós sabemos qual a localização do diretório que estamos. O circulo pintado de vermelho representa o diretório de trabalho.</p>
</div>

Agora nós sabemos que o diretório home do usuário welliton é `/home/welliton`. Por padrão todos os usuários do sistema possui um diretório dentro de `/home` com o mesmo nome do usuário. O sistema de diretório do Linux (e de outros sistemas operacionais) é estruturado como uma __árvore invertida__. A localização mais alta, chamada de __root__ (sim, o mesmo nome do super usuário), é representado por uma barra (`/`) e contém todos os outros diretórios de nível mais baixo.

Um caminho (path em inglês) é __absoluto__ quando o seu início é a raiz do sistema de arquivos, ou seja, quando começa com `/`. Na saída do comando `pwd`, o caminho começa com `/` seguido por `home` seguido por outra `/` (nesse caso é usada para separar os nomes de dois diretórios) seguido por `welliton`.

Resumindo, o comando `pwd` é usado para descobrir qual é o caminho absoluto do diretório de trabalho. E se quisermos mover para outro diretório? O diretório `/home` por exemplo.

O comando `cd` (de _**c**hange **d**irectory_) recebe como argumento o caminho do diretório que nós queremos mover-se até ele. O caminho pode ser absoluto ou __relativo__. O caminho relativo é __dependente__ do diretório de trabalho. Por exemplo, vamos nos mover para o diretório `/home` usando o caminho absoluto.


```bash
cd /home
```

Observe que a linha de _prompt_ mudou para `welliton@desk3:/home$` indicando que agora estamos no diretório `/home`. Se executarmos o comando `pwd` veremos que o diretório de trabalho mudou.


```bash
pwd
```

```
/home
```

<div class="figure">
<!--html_preserve--><div id="htmlwidget-08611ad061dd0b641f29" style="width:96px;height:288px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-08611ad061dd0b641f29">{"x":{"diagram":"digraph start {\n\ngraph []\n\nnode [shape = circle,\n      width = 0.9]\n\"/\" welliton\n\nnode [color = red]\nhome\n\n\"/\" -> home -> welliton [dir = none]\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:unnamed-chunk-7)Mudamos nosso diretório de trabalho para `/home`.</p>
</div>

Agora vamos voltar para o diretório de trabalho anterior (`/home/welliton`) usando o caminho relativo. Pelo diagrama e também pelo caminho absoluto, nós sabemos que o diretório `welliton` está _dentro_ do diretório `home` (nosso diretório de trabalho).


```bash
cd welliton
```

Voltamos para o diretório pessoal do usuário (sabemos pelo `~` na linha de _prompt_). Agora vamos para o diretório raiz do sistema de arquivos. Novamente há duas formas, usando o caminho absoluto e relativo. Primeiro absoluto.


```bash
cd /
```

Simples não? Agora vamos tentar pelo caminho relativo mas antes precisamos voltar para o diretório pessoal do usuário. Lembra que o `~` é um curinga para representar o diretório pessoal?


```bash
cd ~
```

Pronto, voltamos para o diretório pessoal. Executar o comando `cd` sem argumentos também irá nos direcionar para o diretório pessoal. Como ir para o diretório raiz a partir de um subdiretório? O curinga `..` representa o diretório superior. Nós sabemos que o diretório atual está dois níveis acima do diretório raiz.


```bash
cd ../..
```

Pronto! Estamos novamente no diretório raiz!

O diretório raiz contém diversos subdiretórios, cada um armazena arquivos e diretórios separados por seus papéis no sistema operacional. O comando `ls` (de _**l**i**s**t_) lista o conteúdo do diretório passado como argumento. Se não informado nenhum argumento, o comando `ls` irá imprimir a listagem de arquivos do diretório de trabalho (que em nosso caso é `/`).


```bash
ls
```

```
bin    dev   initrd.img  lost+found  opt   run   srv  usr
boot   etc   lib         media       proc  sbin  sys  var
cdrom  home  lib64       mnt         root  snap  tmp  vmlinuz
```

<div class="figure">
<!--html_preserve--><div id="htmlwidget-aca75e9d8881d4e585a7" style="width:672px;height:288px;" class="grViz html-widget"></div>
<script type="application/json" data-for="htmlwidget-aca75e9d8881d4e585a7">{"x":{"diagram":"digraph start {\n\ngraph []\n\nnode [shape = circle,\n      width = 0.9]\nbin boot dev etc home lib media mnt opt proc \"root\" run sbin srv sys tmp usr var welliton\n\nnode [color = red]\n\"/\"\n\n\"/\" -> {bin boot dev etc home lib media mnt opt proc \"root\" run sbin srv sys tmp usr var} [ dir = none ]\nhome -> welliton [ dir = none ]\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:unnamed-chunk-13)Estrutura de diretórios do Linux. Alguns diretórios foram omitidos.</p>
</div>
