targetScope = 'subscription'

@description('Azure region')
param location string

@description('Resource Group name')
param resourceGroupName string

@description('Tags')
param tags object = {}

@description('Virtual Network name')
param virtualNetworkName string

@description('Virtual Network address space')
param addressPrefixes array

@description('Subnet name')
param appsubnetName string

@description('Subnet address prefix')
param appsubnetPrefix string

param networkSecurityGroupName string

module resourceGroup './platform/resourceGroups/resourceGroup.bicep' = {
  name: 'resourceGroupDeployment'
  params: {
    resourceGroupName: resourceGroupName
    location: location
    tags: tags
  }
}

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' existing = {
  name: resourceGroupName
}

module virtualNetwork './platform/networking/virtualNetwork.bicep' = {
  name: 'virtualNetworkDeployment'
  scope: rg
  params: {
    virtualNetworkName: virtualNetworkName
    location: location
    addressPrefixes: addressPrefixes
    tags: tags
  }
  dependsOn: [
    resourceGroup
  ]
}

module networkSecurityGroup './platform/networking/networkSecurityGroup.bicep' = {
  name: 'networkSecurityGroup'
  scope: rg
  params: {
    networkSecurityGroupName: networkSecurityGroupName
  }
}

module subnet './platform/networking/subnet.bicep' = {
  name: 'subnetDeployment'
  scope: rg

  params: {
    virtualNetworkName: virtualNetworkName
    subnetName: appsubnetName
    subnetPrefix: appsubnetPrefix
    networkSecurityGroupId: networkSecurityGroup.outputs.networkSecurityGroupId
  }

  dependsOn: [
    networkSecurityGroup
  ]
}
