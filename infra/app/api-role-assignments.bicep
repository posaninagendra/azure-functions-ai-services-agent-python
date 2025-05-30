param apiPrincipalId string
param principalType string = 'ServicePrincipal' // Workaround for https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-template#new-service-principal

param storageAccountName string
param aiServicesAccountName string

// Assignments for Storage Account
// ------------------------------------------------------------------

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

// Assign the API Storage Blob Data Owner Role on the Storage Account resource

var storageBlobDataOwnerRoleDefinitionId  = 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'

resource storageRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccount.id, apiPrincipalId, storageBlobDataOwnerRoleDefinitionId)
  scope: storageAccount
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', storageBlobDataOwnerRoleDefinitionId)
    principalId: apiPrincipalId
    principalType: principalType
  }
}

// Assign the API Storage Queue Data Contributor Role on the Storage Account resource

var storageQueueDataContributorRoleDefinitionId  = '974c5e8b-45b9-4653-ba55-5f855dd0fb88'

resource storageQueueDataContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccount.id, apiPrincipalId, storageQueueDataContributorRoleDefinitionId)
  scope: storageAccount
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', storageQueueDataContributorRoleDefinitionId)
    principalId: apiPrincipalId
    principalType: principalType
  }
}

// Assign the API Storage Table Data Contributor Role on the Storage Account resource

var storageTableDataContributorRoleDefinitionId  = '0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3'

resource storageTableDataContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccount.id, apiPrincipalId, storageTableDataContributorRoleDefinitionId)
  scope: storageAccount
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', storageTableDataContributorRoleDefinitionId)
    principalId: apiPrincipalId
    principalType: principalType
  }
}

// Assignments for AI Services Account
// ------------------------------------------------------------------

resource account 'Microsoft.CognitiveServices/accounts@2025-04-01-preview' existing = {
   name: aiServicesAccountName
}

// Assign the API Azure AI User Role on the AI Project resource so that it can create and interact
// with agents, threads, messages, and runs.

var azureAiUserRoleDefinitionId = '53ca6127-db72-4b80-b1b0-d745d6d5456d'

resource azureAiUserRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(account.id, apiPrincipalId, azureAiUserRoleDefinitionId)
  scope: account
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', azureAiUserRoleDefinitionId)
    principalId: apiPrincipalId
    principalType: principalType
  }
}
