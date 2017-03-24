# Informações sobre Hardware {#hardware}



Nesse capítulo é apresentado comandos para obter informações do dispositivos instalados (_hardware_) no computador.

## Memória RAM

### Uso da memória RAM

Obter informação sobre memória principal (_RAM_) utilizada e disponível.
O commando `free` imprime uma tabela com essas informações (em _kilobytes_):


```bash
free
```

```
              total        used        free      shared  buff/cache   available
Mem:        4010240     2578624      210096      361464     1221520      813780
Swap:       4157436      420936     3736500
```

Dentre as opções que alteram a unidade de medida, a opção `-h` (ou `--human`) é recomendada por converter em unidades de acordo com os valores de cada unidade.


```bash
free -h
```

```
              total        used        free      shared  buff/cache   available
Mem:           3,8G        2,5G        186M        371M        1,2G        776M
Swap:          4,0G        411M        3,6G
```

No exemplo acima, a memória toal e utilizada aparecem em _gigabytes_ e a memória disponível em _megabytes_.

### Informações da memória RAM

A linha de comando a seguir imprime informações sobre os pentes de memória RAM instalados no computador ([referência](https://www.cyberciti.biz/faq/check-ram-speed-linux/)):


```bash
sudo dmidecode --type 17
```

```
# dmidecode 3.0
Getting SMBIOS data from sysfs.
SMBIOS 2.6 present.

Handle 0x000F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000D
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: Not Specified
	Type: DDR3
	Type Detail: Synchronous
	Speed: 1333 MHz
	Manufacturer:                 
	Serial Number: 03A9D7A7
	Asset Tag: 061125
	Part Number: SH564568FH8N6PHSFG

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000D
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: Not Specified
	Type: DDR3
	Type Detail: Synchronous
	Speed: 1333 MHz
	Manufacturer:                 
	Serial Number: 03A9D6C5
	Asset Tag: 061125
	Part Number: SH564568FH8N6PHSFG
```

Nesse exemplo há dois pentes de memória RAM instalado no desktop.
O tipo da memória (`Type`) é __DDR3__ e o _slot_ (`Form Factor`) é __DIMM__.
O tamanho dos dois pentes de memória instalados (`Size`) é __2 GB__ e a velocidade (`Speed`) é __1333 MHz__.
A seguir um exemplo de informação de memória RAM de um servidor de processamento.


```
# dmidecode 2.12
SMBIOS 2.6 present.

Handle 0x1100, DMI type 17, 28 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 8192 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM_A1 
	Bank Locator: Not Specified
	Type: DDR3
	Type Detail: Synchronous Registered (Buffered)
	Speed: 1333 MHz
	Manufacturer: 00CE00B380CE
	Serial Number: 02657348
	Asset Tag: 13111461
	Part Number: M393B1K70CHD-CH9  
	Rank: 2

...
```

A informação do pente de memória aparece mais 17 vezes!
Dessa forma, esse servidor tem __144 GB__ de memória RAM.
