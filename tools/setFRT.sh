#!/bin/bash

#  aFRTpath=/home/_0/bin
#  aFRTpath=/webs/FormR/tools/_2/bin
   aFRTpath=$( dirname "$( readlink -f "$0" )" )/_2/bin

 if [ ! -d "${aFRTpath}" ]; then
     mkdir -p "${aFRTpath}"
     fi

     echo ""
##   echo "  aFRTpath: ${aFRTpath//\//\\\/}"; # exit

     aTS=$( date +%y%m%d ); aTS=${aTS:1}

	 aPgm1='
'/${aFRTpath//\//\\/}/' { print }'

	 aPgm=!/${aFRTpath//\//\\/}/' { print NR ": " $0 }'
	 aPgm2=/${aFRTpath//\//\\/}/' { print $0 }'
##   echo "   aPGM: $aPgm2"; # exit

#    aPgm3=/${aFRTpath//\//\\/}/' { print NR ": " $0 }; END { print "\n" (NR+1) ": Hello" }'
#    aPgm3='{ print NR ": " $0 }; END { print "\n" (NR+1) ": " "PATH=$PATH:'${aFRTpath}'" }'
	 aPgm3='{ print }; END { print "\nPATH=$PATH:'${aFRTpath}'  # .('${aTS}'.01.1 RAM: Added" }'
##   echo "   aPGM: $aPgm2"; # exit

#            cat /root/.profile | awk '/\/webs\/FormR\/_2\/bin/ { print }'
#    echo "  cat /root/.profile | awk '/${aFRTpath//\//\\/}/ { print }'"; # exit
##   echo "  cat /root/.profile | awk -e \"${aPgm2}\"";  #exit

     aPath=$( cat /root/.profile | awk -e "${aPgm2}" );
##   echo ""; echo "  aPath:"; echo "'${aPath}'" | awk '{ print "   " $0 }'; # exit


 if [ "${aPath}" ]; then bExists=1; else bExists=0; fi
 if [ "${bExists}" == "1" ]; then
     echo "  \$PATH already contains '${aFRTpath}' in /root/.profile"
   else
##   echo "  mv /root/.profile  /root/.profile_v${aTS}"
             mv /root/.profile  /root/.profile_v${aTS}
             cat  /root/.profile_v${aTS} | awk -e "${aPgm3}" >/root/.profile
     echo "  Added '${aFRTpath}' to the \$PATH in /root/.profile"
     echo "  It will be added to the \$PATH the next time you login, or "
     echo "  you can add it not by running: source /root/.profile"
     echo ""
     echo "  Then, from any folder, you can run: frt"

     fi

##   echo "  chmod -R 755 \${aFRTpath/\/bin/}/*"
             chmod -R 755  ${aFRTpath/\/bin/}/*

#    source /root/.profile
     echo ""
