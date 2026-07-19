targetScope = 'resourceGroup'

@description('Network Security Group Name')
param networkSecurityGroupName string

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: networkSecurityGroupName
  location: resourceGroup().location
}

output networkSecurityGroupId string = networkSecurityGroup.id
