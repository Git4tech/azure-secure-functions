param location string = resourceGroup().location
param projectName string = 'securefunc'

module network './network.bicep' = {
  name: 'networkDeployment'
  params: {
    location: location
    projectName: projectName
  }
}

module storage './storage.bicep' = {
  name: 'storageDeployment'
  params: {
    subnetId: network.outputs.privateEndpointSubnetId
    location: location
    projectName: projectName
  }
}

module keyvault './keyvault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    location: location
    projectName: projectName
  }
}

module function './function.bicep' = {
  name: 'functionDeployment'
  params: {
    location: location
    projectName: projectName
    privateEndpointSubnetId: network.outputs.privateEndpointSubnetId
    functionAppId: storage.outputs.functionAppId
    functionAppPrincipalId: storage.outputs.functionAppPrincipalId
    storageAccountId: storage.outputs.storageAccountId
    storageAccountName: storage.outputs.storageAccountName
    keyVaultId: keyvault.outputs.keyVaultId
  }
}

output keyVaultId string = keyvault.outputs.keyVaultId
