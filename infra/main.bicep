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
    subnetId: network.outputs.subnetId
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
    functionAppId: keyvault.outputs.functionAppId
    functionAppPrincipalId: keyvault.outputs.functionAppPrincipalId
    privateEndpointSubnetId: network.outputs.privateEndpointSubnetId
  }
}

output keyVaultId string = keyvault.outputs.keyVaultId
