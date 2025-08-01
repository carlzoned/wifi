﻿TASK1: COLLAPSED BACKBONE: BASIC LAYER3 CONFIGURATION.
!@@@CORE SWITCH SA TAAS
config t
   hostname COREtaas-12
   enable secret pass
   service password-encryption
   no logging console
   no ip domain-lookup
   line console 0
     password pass
     login
     exec-timeout 0 0
    line vty 0 14
      password pass
      login
      exec-timeout 0 0
   Int Vlan 1
     no shutdown
	 ip add 10.12.1.2 255.255.255.0
	 description MGMTDATA
   Int Vlan 10
     no shutdown
	 ip add 10.12.10.2 255.255.255.0
	 description WIRELESS
   Int Vlan 50
     no shutdown
	 ip add 10.12.50.2 255.255.255.0
	 description IPCCTV
   Int Vlan 100
     no shutdown
	 ip add 10.12.100.2 255.255.255.0
	 description VOICEVLAN
end

!!!DAPAT 7 UNDER12SCORE ANG NA EDIT MO  ( LINE 34 to 68 PASTE TO COREBABA SWITCH )
!@@@LeafSwitchONLY
config t
   hostname COREbaba-12
   enable secret pass
   service password-encryption
   no logging console
   no ip domain-lookup
   line console 0
     password pass
     login
     exec-timeout 0 0
    line vty 0 14
      password pass
      login
      exec-timeout 0 0
   Int Gi 0/1
     no shutdown
	  no switchport
	  ip add 10.12.12.4 255.255.255.0
   Int Vlan 1
     no shutdown
	 ip add 10.12.1.4 255.255.255.0
	 description MGMTDATA
   Int Vlan 10
     no shutdown
	 ip add 10.12.10.4 255.255.255.0
	 description WIRELESS
   Int Vlan 50
     no shutdown
	 ip add 10.12.50.4 255.255.255.0
	 description IPCCTV
   Int Vlan 100
     no shutdown
	 ip add 10.12.100.4 255.255.255.0
	 description VOICEVLAN
end

WARNING: IF YOU SEE AMBER/ORANGE= NEEDS FIXING!!!

Trunk Ports: switch to switch:
TAAS/BABA:
config t
Int Range fa0/10-12
 shutdown
 no shutdown
 switchport trunk Encap Dot1Q
 switchport mode trunk
 do sh int trunk
end

CCNPSkillsNow: Etherchannel with LinkAggregationControlProtocol:
WARNING: THREE CABLES IS BETTER THAN ONE!
@taas/BABA:
config t
Int Range fa0/10-12
 channel-group 1 mode active
 channel-protocol Lacp
 do sh etherchannel summary
 do sh int po1 | inc BW


!DHCP: DYNAMIC HOST CONFIGURATION PROTOCOL
!!!DAPAT 21 UNDER SCORE ANG NA EDIT MO  ( LINE 72 to 99 PASTE TO COREBABA SWITCH )
!@@@LEAF SWITCH
config t
ip dhcp Excluded-add 10.12.1.1 10.12.1.100
ip dhcp Excluded-add 10.12.10.1 10.12.10.100
ip dhcp Excluded-add 10.12.50.1 10.12.50.100
ip dhcp Excluded-add 10.12.100.1 10.12.100.100
ip dhcp pool MGMTDATA
   network 10.12.1.0 255.255.255.0
   default-router 10.12.1.4
   domain-name MGMTDATA.COM
   dns-server 10.12.1.10
ip dhcp pool WIFIDATA
   network 10.12.10.0 255.255.255.0
   default-router 10.12.10.4
   domain-name WIFIDATA.COM
   dns-server 10.12.1.10
ip dhcp pool IPCCTV
   network 10.12.50.0 255.255.255.0
   default-router 10.12.50.4
   domain-name IPCCTV.COM
   dns-server 10.12.1.10
ip dhcp pool VOICEVLAN
   network 10.12.100.0 255.255.255.0
   default-router 10.12.100.4
   domain-name VOICEVLAN.COM
   dns-server 10.12.1.10
   option 150 ip 10.12.100.8   
   END

!!CREATING AND PLACING PORTS INSIDEAVLAN:
( LINE 103 to 141 PASTE TO COREBABA SWITCH )
config t
vlan 10
   name WIFIVLAN
vlan 50
   name IPCCTVLAN
vlan 69
   name carlzonedvlan
vlan 70
    name ACCOUNTING
vlan 71
    name HR
vlan 100
   name VOICEVLAN
Int Fa 0/2
  switchport mode access
  switchport access vlan 10  
Int Fa 0/4
  switchport mode access
  switchport access vlan 10
Int Fa 0/6
  switchport mode access
  switchport access vlan 50  
Int Fa 0/8
  switchport mode access
  switchport access vlan 50    
Int Fa 0/3
  switchport mode access
  switchport access vlan 100     
Int Fa 0/5
  switchport mode access  
  switchport voice vlan 100
  mls qos trust device cisco-phone 
  switchport access vlan 1
Int Fa 0/7
  switchport mode access
  switchport voice vlan 100 
  mls qos trust device cisco-phone 
 switchport access vlan 1
 end

!IP CAMERAS NEED MAC ADDRESS RESERVATION FOR FIXED IP SECURITY.  (LINE 144 to 151 PASTE TO COREBABA)
config t
ip routing
ip dhcp pool CAMERA6
host 10.12.50.6 255.255.255.0
client-identifier 001a.0704.7f5b
ip dhcp pool CAMERA8
host 10.12.50.8 255.255.255.0
client-identifier 001a.0709.c258
end
show ip dhcp binding

TASK2***TASK2***TASK2***
TASK2***TASK2***TASK2***
CALLMANAGER EXPRESS CONFIGURATION FOR VOIP/TELEPHONY ENGINEERS
!!cisco unified call manager Express command
!@@@CUCM-M
config t
   hostname CUCM-12
   enable secret pass
   service password-encryption
   no logging console
   no ip domain-lookup
   line console 0
     password pass
     login
     exec-timeout 0 0
    line vty 0 14
      password pass
      login
      exec-timeout 0 0
   Int Fa 0/0
     no shutdown
	 ip add 10.12.100.8 255.255.255.0 
	 end
   
!!!CUCM ANALOG PHONES CONFIG
configure terminal
dial-peer voice 1 pots
   destination-pattern 1200
   port 0/0/0
dial-peer voice 2 pots
   destination-pattern 1201
   port 0/0/1
dial-peer voice 3 pots
   destination-pattern 1202
   port 0/0/2
dial-peer voice 4 pots
   destination-pattern 1203
   port 0/0/3
end

!!IP telephony or Six Digit Salary.
config t   
no telephony-service
telephony-service
   no auto assign
   no auto-reg-ephone
   max-ephones 5
   max-dn 20
   ip source-address 10.12.100.8 port 2000
   create cnf-files
ephone-dn 1
  number 1211
ephone-dn 2
  number 1222
ephone-dn 3
  number 1233
ephone-dn 4
  number 1244
ephone-dn 5
  number 1255
ephone-dn 6
  number 1266
ephone-dn 7
  number 1277
ephone-dn 8
  number 1288
 ephone-dn 9
   number 1299
ephone-dn 10
 number 1298
Ephone 1
  Mac-address ccd8.c1fb.0817
  type 8945
  button 1:8 2:7 3:6 4:5
  restart
Ephone 2
  Mac-address ccd8.c1fb.161b
  type 8945
  button 1:4 2:3 3:2 4:1
  restart  
end

@@@Enabling Video Calls
configure terminal
ephone 1
   video
   voice service voip
   h323
   call start slow
ephone 2
   video
   voice service voip
   h323
   call start slow
end

!!@@allow incoming calls
configure terminal
voice service voip
ip address trusted list
ipv4 0.0.0.0 0.0.0.0
exit

!OUTGOING CALL FROM CUCM TO OTHER CUCM.
configure terminal
 dial-peer voice 11 Voip
 destination-pattern 11..
 session target ipv4:10.11.100.8
 codec g711ULAW
  !dial-peer voice 12 Voip
  !destination-pattern 12..
  !session target ipv4:10.12.100.8
  !codec g711ULAW
dial-peer voice 21 Voip
 destination-pattern 21..
 session target ipv4:10.21.100.8
 codec g711ULAW
dial-peer voice 22 Voip
 destination-pattern 22..
 session target ipv4:10.22.100.8
 codec g711ULAW
dial-peer voice 31 Voip
 destination-pattern 31..
 session target ipv4:10.31.100.8
 codec g711ULAW
dial-peer voice 32 Voip
 destination-pattern 32..
 session target ipv4:10.32.100.8
 codec g711ULAW
dial-peer voice 41 Voip
 destination-pattern 41..
 session target ipv4:10.41.100.8
 codec g711ULAW
dial-peer voice 42 Voip
 destination-pattern 42..
 session target ipv4:10.42.100.8
 codec g711ULAW
dial-peer voice 51 Voip
 destination-pattern 51..
 session target ipv4:10.51.100.8
 codec g711ULAW
dial-peer voice 52 Voip
 destination-pattern 52..
 session target ipv4:10.52.100.8
 codec g711ULAW
dial-peer voice 61 Voip
 destination-pattern 61..
 session target ipv4:10.61.100.8
 codec g711ULAW
dial-peer voice 62 Voip
 destination-pattern 62..
 session target ipv4:10.62.100.8
 codec g711ULAW
dial-peer voice 71 Voip
 destination-pattern 71..
 session target ipv4:10.71.100.8
 codec g711ULAW
dial-peer voice 72 Voip
 destination-pattern 72..
 session target ipv4:10.72.100.8
 codec g711ULAW
dial-peer voice 81 Voip
 destination-pattern 81..
 session target ipv4:10.81.100.8
 codec g711ULAW
dial-peer voice 82 Voip
 destination-pattern 82..
 session target ipv4:10.82.100.8
 codec g711ULAW

TASK3***TASK3***TASK3***
TASK3***TASK3***TASK3***
PRIMARY EDGE ROUTER CONFIGURATION! owned by PLDT !!!
!@@@EDGE ROUTE CONFIG
config t
   hostname EDGE-12
   enable secret pass
   service password-encryption
   no logging console
   no ip domain-lookup
   line console 0
     password pass
     login
     exec-timeout 0 0
    line vty 0 14
      password pass
      login
      exec-timeout 0 0
   Int Gi 0/0/0
     description FIBEROPTIC-TO-SWITCH
     ip add 10.12.12.1 255.255.255.0
	 no shutdown
   Int Gi 0/0/1
     description PLDT-ME-WAN
	 ip add 200.0.0.12 255.255.255.0
	 no shutdown
   Int Loopback 0
     description VIRTUALIP-FOR-ROUTING
	 ip add 12.0.0.1 255.255.255.255
 end

OPEN SHORTEST PATH FIRST/OSPF CONFIG.
@EDGE:
siib: sh ip int brief
sirc: sh ip route connected
@EDGE:
config t
router ospf 1
router-id 12.0.0.1
network 200.0.0.0  0.0.0.255 area 0
network 10.12.12.0  0.0.0.255 area 0
network 12.0.0.1  0.0.0.0 area 0
Interface gi 0/0/0
 ip ospf network point-to-point
end

@CoreBABA:
config t
router ospf 1
router-id 10.12.12.4
network 10.12.0.0  0.0.255.255 area 0
int gi 0/1
 ip ospf network point-to-point
end

@CUCM:
config t
router ospf 1
router-id 10.12.100.8
network 10.12.100.0  0.0.0.255  area 0
end


 !!!STATIC ROUTING FOR MININUM WAGERS: 645php/day
 !!! EDGE route NOT dikit to ClassMate:
conf t
 ip routing 
 ip route 10.11.0.0 255.255.0.0 200.0.0.11
 NO ip route 10.2.0.0 255.255.0.0 200.0.0.12
 ip route 10.21.0.0 255.255.0.0 200.0.0.21
 ip route 10.22.0.0 255.255.0.0 200.0.0.22
 ip route 10.31.0.0 255.255.0.0 200.0.0.31
 ip route 10.32.0.0 255.255.0.0 200.0.0.32
 ip route 10.41.0.0 255.255.0.0 200.0.0.41
 ip route 10.42.0.0 255.255.0.0 200.0.0.42
 ip route 10.51.0.0 255.255.0.0 200.0.0.51
 ip route 10.52.0.0 255.255.0.0 200.0.0.52
 ip route 10.61.0.0 255.255.0.0 200.0.0.61
 ip route 10.62.0.0 255.255.0.0 200.0.0.62
 ip route 10.71.0.0 255.255.0.0 200.0.0.71
 ip route 10.72.0.0 255.255.0.0 200.0.0.72
 ip route 10.81.0.0 255.255.0.0 200.0.0.81
 ip route 10.82.0.0 255.255.0.0 200.0.0.82
 ip route 10.12.0.0 255.255.0.0 10.12.12.4
 NO ip route 10.2.0.0 255.255.0.0 200.0.0.12
 end
 
*********************************************
Layer three/3 switch ROUTING = 300k up!!!
@SWITCH/COREBABA
!SI SWITCH ASA/DIKIT KAY EDGE PARA MAKALABAS
conf t 
ip routing
ip route 0.0.0.0 0.0.0.0 10.12.12.1
end

@CUCM:DEFAULT ROUTING( 0.0.0.0 0.0.0.0) FOR CUCM:
!SI CUCM ASA/DIKIT KAY SWITCH VLAN 100 PARA MAKALABAS
conf t
ip routing
ip route 0.0.0.0 0.0.0.0 10.12.100.4
end

!How to Static Route windows Server:
cmd
route  add   10.0.0.0   mask   255.0.0.0    10.12.1.4
route  add  200.0.0.0   mask  255.255.255.0   10.12.1.4

********************************************

 
@@@@@@@@@IVRS: interActive Voice Response System: maticSagot

config t
dial-peer voice 69 voip
 service rivanaa out-bound
 destination-pattern 1269
 session target ipv4:10.12.100.8
 incoming called-number 1269
 dtmf-relay h245-alphanumeric
 codec g711ulaw
 no vad
!
telephony-service
 moh "flash:/en12bacd12music12on12hold.au"
!
application
 service rivanaa flash:app-b-acd-aa-3.0.0.2.tcl
  paramspace english index 1        
  param number-of-hunt-grps 2
  param dial-by-extension-option 8
  param handoff-string rivanaa
  param welcome-prompt flash:en12bacd12welcome.au
  paramspace english language en
  param call-retry-timer 15
  param service-name rivanqueue
  paramspace english location flash:
  param second-greeting-time 60
  param max-time-vm-retry 2
  param voice-mail 1234
  param max-time-call-retry 700
  param aa-pilot 1269
 service rivanqueue flash:app-b-acd-3.0.0.2.tcl
  param queue-len 15
  param aa-hunt1 1200
  param aa-hunt2 1277
  param aa-hunt3 1201
  param aa-hunt4 1233
  param queue-manager-debugs 1
  param number-of-hunt-grps 4
****************************************************************************
HOW TO FIX THE SHYT
config t
 application
  no service callqueue flash:app-b-acd-2.1.2.2.tcl
  no service rivanaa flash:app-b-acd-aa-2.1.2.2.tcl
!!!THEN PASTE ALL IVR COMMANDS AGAIN
****************************************************************************

OPEN CMD                 DNS
1. ping 10.M.1.10        PC
   ping 10.m.1.4         sw
2. ping 10.M.100.8       cm
   ping 10.m.50.6        c6
   ping 10.m.50.8        c8
   ping 10.m.100.101     p1
   ping 10.m.100.102     p2
3. ping 10.M.M.1         ed
4. ping 200.0.0.M
5. ping 200.0.0.K
6. ping 10.21.1.10
   ping 10.22.1.10
   ping 10.31.1.10
   ping 10.32.1.10
   ping 10.41.1.10
   ping 10.42.1.10

INSTALL DNS - DOMAIN NAME SERVER/system

OPEN CMD

Powershell
Remove-WindowsFeature -name dns
!
Install-WindowsFeature -name dns -includeManagementTools

****************************************************************************
TURN OFF Firewall:

powershell
Set-NetfirewallProfile -name public,private,domain -enabled false

****************************************************************************
WEB SERVER

OPEN CMD

powershell
Remove-WindowsFeature  -name  web-server

Install-WindowsFeature -name web-server -includeManagementTools

New-Website -name "CCNA" -hostheader "www.website.com" -physicalpath "d:\webs\datingbiz" -force
****************************************************************************

show call application sessions
call application session stop id 17
how to clean
config t
application
 NO service rivanaa flash:app-b-acd-aa-3.0.0.2.tcl
 NO service rivanqueue flash:app-b-acd-3.0.0.2.tcl
end
=============================================================
DEBUG COMMANDS
================

=============================================================
DEBUG COMMANDS
=============================================================

          
http://docwiki.cisco.com/wiki/Cisco12IOS12Voice12Troubleshooting12and12Monitoring12--12Tcl12IVR12Troubleshooting

debug voice application ?
debug voice application error
debug voice application script
debug voice application states

conf t
        logging console

========================
CHECK AVAILABLE SERVICES
========================
conf t
        application
                service ?  
***********************************************************

SIP CONFIGURATION: session initiation Protocol: non-Cisco
conf t
 voice service voip
  allow-connections h323 to sip    
  allow-connections sip to h323
  allow-connections sip to sip
  supplementary-service h450.12
 sip
   bind control source-interface fa0/0
   bind media source-interface fa0/0
   registrar server expires max 600 min 60
!
 voice register global
  mode cme
  source-address 10.12.100.8 port 5060
  max-dn 12
  max-pool 12
  authenticate register
  create profile sync
 voice register dn 1
   number 1275
   allow watch
   name 1275
 voice register dn 2
   number 1276
   allow watch
   name 1276
!
  voice register pool 1
    id mac 341c.f0d6.534c
    number 1 dn 1
    dtmf-relay sip-notify
    username 1275 password 1275
    codec g711ulaw
!
  voice register pool 2
    id mac 5050.a445.72b4
    number 1 dn 2
    dtmf-relay sip-notify
    username 1276 password 1276
    codec g711ulaw
!
*******call other countries!!!********
config t
!
dial-peer voice 12 voip
destination-pattern k..
session protocol sipv2
session target sip-server
codec g711ulaw
exit
          
sip-ua
sip-server ipv4:192.168.k.1
