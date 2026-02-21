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
    location: location
    projectName: projectName
    subnetId: network.outputs.privateEndpointSubnetId
  }
}

module keyvault './keyvault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    location: location
    projectName: projectName
    subnetId: network.outputs.privateEndpointSubnetId
  }
}

module function './function.bicep' = {
  name: 'functionDeployment'
  params: {
    functionAppId: functionApp.outputs.functionAppId
    functionAppPrincipalId: functionApp.outputs.functionAppPrincipalId
    privateEndpointSubnetId: network.outputs.privateEndpointSubnetId
    location: location
    projectName: projectName
    functionSubnetId: network.outputs.functionSubnetId
    storageAccountName: storage.outputs.storageAccountName
  }
}


output keyVaultId string = keyvault.outputs.keyVaultId
