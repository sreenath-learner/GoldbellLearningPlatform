targetScope = 'resourceGroup'

@description('Virtual Network name')
param virtualNetworkName string

@description('Subnet name')
param subnetName string

@description('Subnet address prefix')
param subnetPrefix string

param networkSecurityGroupId string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' existing = {
  name: virtualNetworkName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2025-01-01' = {
  parent: virtualNetwork
  name: subnetName

  properties: {
    addressPrefix: subnetPrefix
  networkSecurityGroup: {
    id: networkSecurityGroupId
  }
}
  }

output subnetId string = subnet.id
output subnetName string = subnet.name
