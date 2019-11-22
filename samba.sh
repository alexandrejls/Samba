#!/bin/bash
# O SAMBA4 é uma reimplementação de software livre do protocolo de rede SMB e foi originalmente desenvolvido por
# Andrew Tridgell. O Samba fornece serviços de arquivo e impressão para vários clientes do Microsoft Windows e 
# pode se integrar a um domínio do Microsoft Windows Server, como um controlador de domínio (DC) ou como um 
# membro do domínio. A partir da versão 4, ele suporta domínios do Active Directory e do Microsoft Windows NT.
#
# O KERBEROS Kerberos é o nome de um Protocolo de rede, que permite comunicações individuais seguras e identificadas, 
# em uma rede insegura. Para isso o Massachusetts Institute of Technology (MIT) disponibiliza um pacote de aplicativos que 
# implementam esse protocolo. O protocolo Kerberos previne Eavesdropping e Replay attack, e ainda garante a integridade dos 
# dados. Seus projetistas inicialmente o modelaram na arquitetura cliente-servidor, e é possível a autenticação mutua entre 
# o cliente e o servidor, permitindo assim que ambos se autentiquem.
#
# O NTP é um protocolo para sincronização dos relógios dos computadores baseado no protocolo UDP sob a porta 123. 
# É utilizado para sincronização do relógio de um conjunto de computadores e dispositivos em redes de dados com latência 
# variável. O NTP permite manter o relógio de um computador sincronizado com a hora sempre certa e com grande exatidão. 
# Foi originalmente idealizado por David L. Mills da Universidade do Delaware e ainda hoje é mantido por ele e por uma 
# equipe de voluntários. 
# Variável da Data Inicial para calcular o tempo de execução do script (VARIÁVEL MELHORADA)
# opção do comando date: +%T (Time)
HORAINICIAL=`date +%T`
#
# Variáveis para validar o ambiente, verificando se o usuário e "root", versão do ubuntu e kernel
# opções do comando id: -u (user)
# opções do comando: lsb_release: -r (release), -s (short), 
# opões do comando uname: -r (kernel release)
# opções do comando cut: -d (delimiter), -f (fields)
# opção do shell script: piper | = Conecta a saída padrão com a entrada padrão de outro comando
# opção do shell script: acento crase ` ` = Executa comandos numa subshell, retornando o resultado
# opção do shell script: aspas simples ' ' = Protege uma string completamente (nenhum caractere é especial)
# opção do shell script: aspas duplas " " = Protege uma string, mas reconhece $, \ e ` como especiais
USUARIO=`id -u`
UBUNTU=`lsb_release -rs`
KERNEL=`uname -r | cut -d'.' -f1,2`
#
# Variável do caminho do Log dos Script utilizado nesse curso (VARIÁVEL MELHORADA)
# opções do comando cut: -d (delimiter), -f (fields)
# $0 (variável de ambiente do nome do comando)
LOG="/var/log/$(echo $0 | cut -d'/' -f2)"
#
# Variáveis de configuração do Kerberos e SAMBA4
#REALM="PTI.INTRA"
#NETBIOS="PTI"
#DOMAIN="pti.intra"
#FQDN="ptispo01ws01.pti.intra"
#IP="172.16.1.20"
#
# Variáveis de configuração do NTP Server
#NTP="a.st1.ntp.br"
#
# Variáveis de configuração do SAMBA4
#ROLE="dc"
#DNS="SAMBA_INTERNAL"
#USER="administrator"
#PASSWORD="pti@2018"
#LEVEL="2008_R2"
#SITE="PTI.INTRA"
#INTERFACE="enp0s3"
#GATEWAY="172.16.1.254"
#
# Variáveis de configuração do DNS
#ARPA="1.16.172.in-addr.arpa"
#ARPAIP="20"
#
# Exportando o recurso de Noninteractive do Debconf para não solicitar telas de configuração
export DEBIAN_FRONTEND="noninteractive"
#
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando hostname: -I (all IP address)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
#
echo -e "Instalação do SAMBA4 no GNU/Linux \n"
echo -e "Aguarde, esse processo demora um pouco dependendo do seu Link de Internet...\n"
sleep 5
#
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Adicionando o Repositório Multiversão do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	add-apt-repository multiverse &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando as listas do Apt, aguarde..."
	#opção do comando: &>> (redirecionar a entrada padrão)
	apt update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Atualizando o sistema, aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes)
	apt -y upgrade &>> $LOG
echo -e "Sistema atualizado com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Removendo software desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes)
	apt -y autoremove &>> $LOG
echo -e "Software removidos com sucesso!!!, continuando com o script..."
sleep 5
clear
#
echo -e "Instalando o SAMBA4, aguarde..."
echo
#
echo -e "Instalando as dependências do SAMBA4, aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes), \ (bar left) quedra de linha na opção do apt
	apt -y install ntp ntpdate build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls28-dev libreadline-dev \
	python-dev libpam0g-dev python-dnspython gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev docbook-xsl acl \
	attr debconf-utils figlet &>> $LOG
echo -e "Dependências instaladas com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalando o SAMBA4, aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando apt: -y (yes), \ (bar left) quedra de linha na opção do apt
	apt -y install samba samba-common smbclient &>> $LOG
echo -e "Instalação do SAMBA4 feito com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Promovendo o SAMBA4 , aguarde..."
	# opção do comando: &>> (redirecionar a entrada padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando systemctl: stop (), disable (), mask (), unmask (), enable ()
	# opção do comando samba-tool: domain (), provision ()
	systemctl stop smbd.service &>> $LOG
	mv -v /etc/samba/smb.conf /etc/samba/smb.conf.old &>> $LOG
	systemctl disable smbd.service  &>> $LOG
echo -e "Controlador de Domínio SAMBA4 promivido com sucesso!!!, continuando com o script..."
sleep 5
echo
#
echo -e "Instalação do SAMBA4 feita com Sucesso!!!, recomendado reinicializar o servidor no final da instalação."
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=`date +%T`
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`\n" &>> $LOG
read
exit 1
© 2019 GitHub, Inc.
