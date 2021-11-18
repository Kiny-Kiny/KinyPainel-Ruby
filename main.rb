# Módulos
require (
  "rest-client"
)
require (
  "json"
)
require(
  'rbconfig'
)
# Variáveis de corss.
Vermelho="\033[1;31m";Azul="\033[1;34m";Branco="\033[1;37m";Verde="\033[1;32m"
# Função para limpar terminal.
def clear()
  Gem.win_platform? ? (system "cls") : (system "clear")
end
# Função para fazer requisições get e converter elas para json.
def requests(url)
  return JSON.parse(RestClient.get(url).body)
end
# Funções de consulta.
def nome(logo)
  print "#{logo}\n#{Branco}Digite o nome-completo que deseja buscar #{Verde}>>> "
  cons=gets.chomp.to_s
  begin
    result=requests("http://ghostcenter.xyz/api/nome/%s"%cons.gsub(" ","%20"))
    begin
      msg=""
      for i in result['dados'] do
        msg=msg+"\n%sNOME%s - %s\n%sCPF%s - %s\n%sANIVERSÁRIO%s - %s\n%sSEXO%s - %s\n"%[Azul,Branco,i['nome'],Azul,Branco,i['cpf'],Azul,Branco,i['nascimento'],Azul,Branco,i['sexo']]
      end
      rescue Exception
        msg="\n%s<%s NOME NÃO ENCONTRADO OU CURTO DEMAIS%s >%s\n"%[Vermelho,Branco,Vermelho,Branco]
    end
    rescue Exception
      msg="\n%s<%s API OFFLINE OU SERVIDOR FORA DO AR %s>%s\n"%[Vermelho,Branco,Vermelho,Branco]
  end
  clear()
  print "%s%s\n%s<%s APERTE ENTER PARA RETORNAR AO MENU %s>%s"%[logo,msg,Azul,Branco,Azul,Branco]
  return gets.chomp
end
#16996273400
def telefone(logo)
  print "%s\n%sDigite o número que deseja consultar %s>>> "%[logo,Branco,Verde]
  cons=gets.chomp
  cons=cons.to_s
  cons=cons.gsub(" ","%20")
  begin
    result=requests("http://217.21.76.120/Api/telefone/telefone.php?tel=%s"%cons)
    msg=""
    begin
      for i in result['msg'] do
        msg=msg+"\n%sNome%s - %s\n%sCPF%s - %s\n%sTipo%s - %s\n%sOperadora%s - %s\n"%[Azul,Branco,i['nome'],Azul,Branco,i['cpf_cnpj'],Azul,Branco,i['tipo'],Azul,Branco,i['operadora']]
      end
    rescue Exception
      msg="\n#{Vernelho}< #{Branco}TELEFONE NÃO ENCONTRADO #{Vermelho}>#{Branco}\n"
    end
  rescue Exception
    msg="\n%s<%s API OFFLINE OU SERVIDOR FORA DO AR %s>\n%s"%[Vermelho,Branco,Vermelho,Branco]
  end
  clear()
  print "%s%s\n%s<%s APERTE ENTER PARA RETORNAR AO MENU %s>%s"%[logo,msg,Azul,Branco,Azul,Branco]
  return gets.chomp
end

def cpf(logo)
  print "%s\n%sDigite o CPF que deseja consultar %s>>> "%[logo,Branco,Verde]
  op=gets.chomp.to_s
  if op.length !=11
    msg="%s<%s FORMATO INVÁLIDO %s>%s"%[Vermelho,Branco,Vermelho,Branco]
  else
    begin
      result=requests("http://191.235.72.119/api/v1/esus/?q=%s"%op)
      msg=""
      begin
        for c in result["dados"]
          c.each do | i |
            msg+="#{Azul}%s#{Branco} - %s\n"%[i[0].upcase,i[1]]
          end
        end
        msg="\n%s"%msg
      rescue Exception
        msg="\n#{Vermelho}<#{Branco} CPF NÃO ENCONTRADO #{Vermelho}>#{Branco}\n"
      end
    rescue Exception
      msg="\n%s<%s API OFFLINE OU SERVIDOR FORA DO AR %s>%s\n"%[Vermelho,Branco,Vermelho,Branco]
    end
  end
  clear()
  print "%s%s\n%s<%s APERTE ENTER PARA RETORNAR AO MENU %s>%s"%[logo,msg,Azul,Branco,Azul,Branco]
  return gets.chomp
end

def cns(logo)
  print "#{logo}\n#{Branco} Digite o CNS que irá consultar #{Verde}>>> "
  op=gets.chomp.to_s
  if op.length !=15
    msg="%s<%s FORMATO INVÁLIDO %s>%s"%[Vermelho,Branco,Vermelho,Branco]
  else
    begin
      result=requests("http://191.235.72.119/api/v1/esus/?q=%s"%op)
      msg=""
      begin
        for c in result["dados"]
          c.each do | i |
            msg+="%s%s%s - %s\n"%[Azul,i[0].upcase,Branco,i[1]]
          end
        end
      rescue Exception
        msg="\n%s<%s CPF NÃO ENCONTRADO %s>%s\n"%[Vermelho,Branco,Vermelho,Branco]
      end
    rescue Exception
      msg="\n%s<%s API OFFLINE OU SERVIDOR FORA DO AR %s>%s\n"%[Vermelho,Branco,Vermelho,Branco]
    end
  end
  clear()
  print "%s%s\n%s<%s APERTE ENTER PARA RETORNAR AO MENU %s>%s"%[logo,msg,Azul,Branco,Azul,Branco]
  return gets.chomp
end

def pix(logo)
  op=0
  chaves={"1"=>"cpf","2"=>"telefone","3"=>"email","4"=>"aleatoria","5"=>"cnpj"}
  while chaves[op].nil?
    clear()
    print "%s\n%s===========================%s\n[ %s1%s ] CPF\n[ %s2%s ] Telefone\n[ %s3%s ] Email\n[ %s4%s ] Aleatória\n[ %s5%s ] CNPJ\nEscolha o tipo da Chave %s>>>%s "%[logo,Azul,Branco,Azul,Branco,Azul,Branco,Azul,Branco,Azul,Branco,Azul,Branco,Azul,Verde]
    op=gets.chomp
  end
  clear()
  print "%s\n%sDigite a Chave que deseja consultar %s>>> "%[logo,Branco,Verde]
  op_2=gets.chomp
  begin
    result=requests("https://kiritinho.dev/api/pix?chave="+op_2+"&type="+chaves[op])
    begin
      msg="\n#{Azul}PESSOA CPF#{Branco} - %s\n#{Azul}PESSOA NOME#{Branco} - %s\n#{Azul}PESSOA TIPO - %s\n#{Azul}BANCO CONTA #{Branco}- %s\n#{Azul}BANCO AGÊNCIA #{Branco}- %s\n#{Azul}BANCO NOME#{Branco} - %s\n#{Azul}BANCO TIPO #{Branco}- %s\n" %[result['pessoa']["cpf"],result['pessoa']["nome"],result['pessoa']["tipo"],result['banco']["conta"],result['banco']["agencia"],result['banco']["nome"],result['banco']["tipo"]]
    rescue Exception
      msg="\n%s<%s CHAVE PIX NÃO ENCONTRADA %s>%s\n"%[Vermelho,Branco,Vermelho,Branco]
    end
  rescue Exception => e
    msg=e+"\n%s<%s API OFFLINE OU SERVIDOR FORA DO AR %s>%s\n"%[Vermelho,Branco,Vermelho,Branco]
  end
  clear()
  print "%s%s\n%s<%s APERTE ENTER PARA RETORNAR AO MENU %s>%s"%[logo,msg,Azul,Branco,Azul,Branco]
  return gets.chomp
end

# Banner.
logo='  __  __     __     __   __     __  __    
 /\ \/ /    /\ \   /\ "-.\ \   /\ \_\ \   
 \ \  _"-.  \ \ \  \ \ \-.  \  \ \____ \  
  \ \_\ \_\  \ \_\  \ \_\\"\_\   \/\_____\ 
   \/_/\/_/   \/_/   \/_/ \/_/   \/_____/ '
logo="#{Azul}#{logo}#{Branco}"
logo+="\n #{Azul}Pix #{Branco}: (21) 97918-0533\n"

# Loop para manter o menu rodando.
Sair=false
while(Sair==false) do
  clear()
  print "#{logo}\n#{Azul}===========================#{Branco}\n[ #{Azul}1#{Branco} ] Consulta de Nome\n[ #{Azul}2#{Branco} ] Consulta de CPF\n[ #{Azul}3#{Branco} ] Consulta de CNS\n[ #{Azul}4#{Branco} ] Consulta de Telefone\n[ #{Azul}5#{Branco} ] Consulta de PIX\n#{Azul}==========================#{Branco}\n[ #{Verde}99#{Branco} ] Atualizar\n[ #{Vermelho}00#{Branco} ] Sair\n#{Azul}>>> #{Verde}"
  option=gets.chomp
  clear()
  case option
    when "1"
      nome(logo)
    when "2"
      cpf(logo)
    when "3"
      cns(logo)
    when "4"
      telefone(logo)
    when "5"
      pix(logo)
    when "99"
      system "git pull"
    when "00"
      Sair=true
  end
end
clear()
