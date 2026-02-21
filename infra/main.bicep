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
    kvResourceId: 'your-key-vault-resource-id'
  }
}

module function './function.bicep' = {
  name: 'functionDeployment'
  params: {
    location: location
    projectName: projectName
    functionSubnetId: network.outputs.functionSubnetId
    storageAccountName: storage.outputs.storageAccountName
  }
}
module rbac './rbac.bicep' = {
  name: 'rbacDeployment'
  params: {
    functionPrincipalId: function.outputs.functionPrincipalId
    keyVaultId: keyvault.outputs.keyVaultId
    storageAccountId: storage.outputs.storageAccountId
  }
}
