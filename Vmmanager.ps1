#CRIADO POR Luis Antonio Soares da Silva (lui_eu@msn.com)
#NECESSARIO POWERCLI
<#
    -------------------------- Example 1 --------------------------

    Connect-VIServer -Server 10.23.112.235 -Protocol https -User admin -Password pass

    Connects to a vSphere server by using the User and Password parameters.
    -------------------------- Example 2 --------------------------

    Connect-VIServer Server -Credential $myCredentialsObject -Port 1234

    Connects to a vSphere server by using a credential object.
    -------------------------- Example 3 --------------------------
#>

$vcentermatrix = ""

#IGNORE CERTIFICATE ERROR
$disablecert = Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

#FUNCAO VCENTER CONNECT
function connectvcenter {

    do {
    Write-host -ForegroundColor DarkGreen "Em qual VCENTER/ESXI Deseja conectar?"

    Write-host -ForegroundColor DarkGreen "
    (1) MATRIX ($vcentermatrix)
    (2) ;
    (3) ;
    (4) ;
    (5) ;
    (P) Personalizado
    (S) Sair
    Digite o numero correspondente a opcao e pressione enter:"
    $opt= Read-host 
 

    switch ($opt){
   

        1 {$vcenterserver = $vcentermatrix }
        2 {$vcenterserver = $null }
        3 {$vcenterserver = $null }
        4 {$vcenterserver = $null }
        5 {$vcenterserver = $null }
        P {write-host -ForegroundColor DarkCyan "DIGITE O IP OU NOME DO VCENTER/ESXI"
           $vcenterserver = read-host }

        #A {AutomaticStart}
        S {Write-host "SAIR"}
        Default {write-host -ForegroundColor Red "Opcao Invalida"}

    

        }
 
        #CONNECT TO SELECTED SERVER
         if($vcenterserver -ne $null) {
            $cred = get-credential
            Connect-VIServer -Server $vcenterserver -Protocol https -Credential $cred
            $opt = "s"
         }

    } until ($opt -imatch "s")


}

function showVMS {

    do {
    Write-host -ForegroundColor DarkGreen "Listar as VMS:"

    Write-host -ForegroundColor DarkGreen "
    (1) Todas
    (2) Ligadas
    (3) Desligadas/Outros Status (Não ligadas)
    (4) Por Cliente
    (S) Sair
    Digite o numero correspondente a opcao e pressione enter:"
    $opt= Read-host 
 

    switch ($opt){
   

        1 {Get-VM |select Name,PowerState,ResourcePool |Sort-Object -Property ResourcePool}
        2 {Get-VM |select Name,PowerState,ResourcePool |Sort-Object -Property ResourcePool |Where-Object {$_.PowerState -ieq "PoweredOn"} }
        3 {Get-VM |select Name,PowerState,ResourcePool |Sort-Object -Property ResourcePool |Where-Object {$_.PowerState -ine "PoweredOn"} }
        4 { write-host "Informe o nome do cliente, em caso de duvida coloque parte do nome entre '*'. Exemplo: *matr*"
            $cliente = Read-host
            Get-VM |select Name,PowerState,ResourcePool |Sort-Object -Property ResourcePool |Where-Object {$_.ResourcePool -ilike "$cliente"} }
        5 {$vcenterserver = $null }
        P {write-host -ForegroundColor DarkCyan "DIGITE O IP OU NOME DO VCENTER/ESXI"
           $vcenterserver = read-host }

        #A {AutomaticStart}
        S {Write-host "SAIR"}
        Default {write-host -ForegroundColor Red "Opcao Invalida"}
    }
  }until ($opt -imatch "s")

}


do {
Write-host -ForegroundColor DarkCyan "O que deseja fazer?"

Write-host -ForegroundColor DarkCyan "
(1) Conectar no VCENTER;
(2) Listar Maquinas Virtuais;
(3) ;
(4) ;
(5) ;

(S) Sair
Digite o numero correspondente a opcao e pressione enter:"
$opt= Read-host 

switch ($opt){
    

    1 {connectvcenter}
    2 {showvms}
    3 {valtibco}
    4 {startiproc}
    5 {validaiproc}

    #A {AutomaticStart}
    S {Write-host "SAIR"}
    Default {write-host -ForegroundColor Red "Opcao Invalida"}


    }


} until ($opt -imatch "s")





