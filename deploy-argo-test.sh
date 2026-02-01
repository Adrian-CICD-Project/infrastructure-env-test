#!/bin/bash

# --- KONFIGURACJA ---
RESOURCE_GROUP="rg-devops-poc01"
CLUSTER_NAME="devops-poc01-test"
CONTEXT="devops-poc01-test"
MANIFEST="argocd-adrian-java-app-test.yaml"

echo "---------------------------------------------------"
echo "🚀 Wdrażanie aplikacji testowej na klaster: TEST"
echo "📂 Repozytorium: infrastructure-env-test"
echo "---------------------------------------------------"

# 1. Pobranie poświadczeń
echo "🔄 Odświeżanie poświadczeń AKS ($CLUSTER_NAME)..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --overwrite-existing

# 2. Przełączenie kontekstu
echo "🎯 Ustawianie kontekstu na $CONTEXT..."
kubectl config use-context $CONTEXT

# 3. Weryfikacja i aplikowanie
if [ -f "$MANIFEST" ]; then
    echo "📄 Aplikowanie manifestu: $MANIFEST..."
    kubectl apply -f $MANIFEST
    
    if [ $? -eq 0 ]; then
        echo "✅ Sukces: Aplikacja została zarejestrowana w ArgoCD."
    else
        echo "❌ Błąd: kubectl apply nie powiodło się."
        exit 1
    fi
else
    echo "⚠️ Błąd: Nie znaleziono pliku $MANIFEST!"
    echo "Upewnij się, że jesteś w głównym folderze repozytorium infrastructure-env-test."
    exit 1
fi

echo "---------------------------------------------------"
echo "🏁 Gotowe."