

function createHosp3 {

  echo
	echo "Enroll the CA admin of hosp3"
  echo
	mkdir -p ../organizations/peerOrganizations/hosp3.healthblock.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/
#  rm -rf $FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml
#  rm -rf $FABRIC_CA_CLIENT_HOME/msp

  set -x
  fabric-ca-client enroll -u https://hosp3admin:hosp3healthblock@localhost:11054 --caname ca-hosp3 --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-hosp3.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-hosp3.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-hosp3.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-hosp3.pem
    OrganizationalUnitIdentifier: orderer' > ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/msp/config.yaml

  echo
	echo "Register peer0 of hosp3"
  echo
  set -x
	fabric-ca-client register --caname ca-hosp3 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

  echo
  echo "Register user of hosp3"
  echo
  set -x
  fabric-ca-client register --caname ca-hosp3 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

  echo
  echo "Register the hosp3 admin"
  echo
  set -x
  fabric-ca-client register --caname ca-hosp3 --id.name hosp3hosp3admin --id.secret hosp3hosp3healthblock --id.type admin --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

	mkdir -p ../organizations/peerOrganizations/hosp3.healthblock.com/peers
  mkdir -p ../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com

  echo
  echo "## Generate the peer0 msp for hosp3"
  echo
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-hosp3 -M ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/msp --csr.hosts peer0.hosp3.healthblock.com --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates for hosp3"
  echo
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-hosp3 -M ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls --enrollment.profile tls --csr.hosts peer0.hosp3.healthblock.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null


  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/ca.crt
  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/server.crt
  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/server.key

  mkdir ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/msp/tlscacerts
  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/tlsca
  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/tlsca/tlsca.hosp3.healthblock.com-cert.pem

  mkdir ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/ca
  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/peers/peer0.hosp3.healthblock.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/ca/ca.hosp3.healthblock.com-cert.pem

  mkdir -p ../organizations/peerOrganizations/hosp3.healthblock.com/users
  mkdir -p ../organizations/peerOrganizations/hosp3.healthblock.com/users/User1@hosp3.healthblock.com

  echo
  echo "## Generate the user msp for hosp3"
  echo
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-hosp3 -M ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/users/User1@hosp3.healthblock.com/msp --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/users/User1@hosp3.healthblock.com/msp/config.yaml

  mkdir -p ../organizations/peerOrganizations/hosp3.healthblock.com/users/Admin@hosp3.healthblock.com

  echo
  echo "## Generate the hosp 3 admin msp"
  echo
  set -x
	fabric-ca-client enroll -u https://hosp3hosp3admin:hosp3hosp3healthblock@localhost:11054 --caname ca-hosp3 -M ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/users/Admin@hosp3.healthblock.com/msp --tls.certfiles ${PWD}/fabric-ca/hosp3/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/hosp3.healthblock.com/users/Admin@hosp3.healthblock.com/msp/config.yaml

}
