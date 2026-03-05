# MagicTokens

Um app iOS minimalista que exibe tokens de Magic: The Gathering, utilizando as imagens e dados da API do [Scryfall](https://scryfall.com/docs/api).

## 📱 Sobre o Projeto

MagicTokens é um aplicativo iOS desenvolvido em Swift que permite aos usuários visualizar e explorar tokens do jogo Magic: The Gathering. O app consome a API pública do Scryfall para buscar e exibir imagens de alta qualidade.

## ✨ Funcionalidades Implementadas

### Funcionalidades Principais
- **Lista de Tokens**: Exibição de tokens em formato de grid com scroll infinito com paginação
- **Visualização Detalhada**: Tela de detalhes para visualizar cada token em tamanho maior
- **Sistema de Filtros**: Filtragem de tokens por:
  - Nome (busca textual)
  - Cor (Branco, Azul, Preto, Vermelho, Verde, Incolor)
- **Cache de Imagens**: Sistema de cache para otimizar o carregamento e reduzir o uso de dados
- **Tratamento de Erros**: Alertas informativos com opção de tentar novamente em caso de falha na rede
- **Loading States**: Indicadores visuais de carregamento durante requisições

### Arquitetura e Padrões
- **MVVM-C (Model-View-ViewModel-Coordinator)**: Arquitetura limpa com separação de responsabilidades
- **Protocol-Oriented Programming**: Uso extensivo de protocolos para desacoplamento e testabilidade
- **Dependency Injection**: Injeção de dependências através de `DependencyContainer` para facilitar testes
- **Coordinator Pattern**: Navegação gerenciada por coordenadores, removendo a lógica de navegação das ViewControllers
- **Combine Framework**: Uso de `Combine` para reatividade e binding entre ViewModel e View
- **Módulo CommonKit**: Biblioteca compartilhada contendo:
  - Serviços de rede genéricos e reutilizáveis
  - Sistema de cache de imagens
  - Transformadores de dados (JSON, Imagens)
  - Protocolos para testabilidade

### Estrutura do Projeto
```
MagicTokens/
├── Application/          # AppDelegate, SceneDelegate, DependencyContainer
├── Source/
│   ├── Coordinators/     # Coordenadores de navegação (AppCoordinator, AlertErrorCoordinator)
│   ├── Extensions/       # Extensões úteis para UIKit
│   ├── Features/
│   │   ├── TokenList/    # Lista de tokens (View, ViewModel, ViewController, Coordinator)
│   │   ├── TokenDisplay/ # Detalhes do token
│   │   └── TokenFilter/  # Tela de filtros
│   ├── Models/          # Modelos de dados
│   └── Resources/       # Strings, Constants, Theme
└── CommonKit/           # Módulo compartilhado (Network, ImageCache, Transformers)
```

### Testes
- **Cobertura de Testes**: Testes unitários para ViewModels, ViewControllers, Coordinators e serviços
- **Mocks e Stubs**: Sistema robusto de mocks para facilitar testes isolados
- **Test Plan**: Configuração de test plan para execução automatizada

## 🏗️ Arquitetura MVVM-C

O projeto segue a arquitetura **MVVM-C (Model-View-ViewModel-Coordinator)**:

- **Model**: Representa os dados e a lógica de negócio
- **View**: Componentes de UI (Views e ViewControllers) - apenas apresentação
- **ViewModel**: Lógica de apresentação e estado da tela, reativa com Combine
- **Coordinator**: Gerencia navegação e fluxo da aplicação, desacoplando ViewControllers

### Fluxo de Dados
1. **View** observa mudanças no `screenModel` do **ViewModel** através de `Combine`
2. **ViewModel** processa ações do usuário e coordena com serviços (Network, Cache)
3. **Coordinator** gerencia navegação entre telas e apresentação de alertas
4. **DependencyContainer** fornece instâncias compartilhadas de serviços

### Benefícios da Arquitetura
- **Testabilidade**: ViewModels e Coordinators podem ser testados isoladamente
- **Manutenibilidade**: Separação clara de responsabilidades
- **Reutilização**: ViewModels e serviços podem ser reutilizados
- **Desacoplamento**: Views não conhecem outras Views, apenas Coordinators

## 🚀 Como Executar

### Requisitos
- Xcode 15.0 ou superior
- iOS 16.0 ou superior

### Instalação
1. Clone o repositório
2. Abra o projeto `MagicTokens.xcodeproj` no Xcode
3. Selecione um simulador ou dispositivo iOS
4. Execute o projeto (⌘R)

### Executar Testes
- Para executar todos os testes: ⌘U

### Qualidade de Código (SwiftLint)
- O projeto utiliza **SwiftLint** para manter o padrão de código Swift.
- O SwiftLint é executado automaticamente no pipeline de **CI** (GitHub Actions) no job `swiftlint`, que:
  - Roda o `swiftlint` no diretório `MagicTokens`
  - Gera um artefato `swiftlint-report` com o log completo de warnings
- Warnings de lint **não quebram o build**, mas devem ser tratados aos poucos para manter a qualidade do código.

## 📋 TO DO / Melhorias Futuras

### Funcionalidades Pendentes
- [ ] **Filtros Avançados**: Implementar filtros adicionais como:
  - Filtro por Power/Toughness
  - Filtro por tipo de criatura
  - Filtros combinados mais complexos
- [ ] **Persistência Local**: 
  - Salvar tokens favoritos
  - Cache offline de tokens visualizados recentemente
  - Histórico de buscas
- [ ] **Analytics e Logging**:
  - Integração com ferramenta de analytics (Firebase Analytics)
  - Integração com Crashlytics (Firebase Crashlytics) para monitoramento de crashes e erros
  - Logging estruturado para debugging e monitoramento
  - Tracking de eventos do usuário (visualizações, filtros aplicados, etc.)
  - Monitoramento de performance e métricas de uso
  - Relatórios de crashes em tempo real com stack traces
- [ ] **Acessibilidade**:
  - Labels de acessibilidade para elementos interativos
  - Contraste adequado para leitores de tela
- [ ] **Melhorias de UX**:
  - Pull-to-refresh na lista de tokens
  - Animações de transição mais suaves
- [ ] **Internacionalização**:
  - Suporte a múltiplos idiomas
  - Localização de strings e mensagens

### Melhorias Técnicas
- [ ] **CI/CD**: 
  - Pipeline de integração contínua
  - Testes automatizados em pull requests
  - Distribuição automática para TestFlight
- [ ] **Error Handling**:
  - Tratamento de erros mais granular
  - Mensagens de erro mais específicas

## 🛠️ Tecnologias Utilizadas

- **UIKit**: Framework de interface do usuário
- **Combine**: Framework reativo para programação assíncrona
- **URLSession**: Para requisições de rede
- **Scryfall API**: API pública para dados de Magic: The Gathering

## 👤 Autor

Giordano Mattiello

---
