[dockerservers]
%{ for ip in dockerservers ~}
${ip}
%{ endfor ~}
