targetScope = 'resourceGroup'

@description('Virtual Network name')
param virtualNetworkName string

@description('Azure region')
param location string

@description('Virtual Network address space')
param addressPrefixes array

@description('Tags')
param tags object = {}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: virtualNetworkName
  location: location
  tags: tags

  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
  }
}

output virtualNetworkId string = virtualNetwork.id
output virtualNetworkName string = virtualNetwork.name
