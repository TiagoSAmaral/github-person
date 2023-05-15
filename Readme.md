# Github Person

Após clonar o repositório, deve-se alterar a URL de origin do seu repositório local.

Ver:  [git set-url remote](https://git-scm.com/docs/git-remote#Documentation/git-remote.txt-emset-urlem).

---

## Preparando o Ambiente

Para instalar e utilizar os recursos deste projeto, siga os passos abaixo.

Sobre o projeto: <br>
- Xcode Version 14.2 ou superior<br>
- Suporte mínimo ao iOS 14<br>
- Swift 5<br>

#### Ferramentas de Gestão e Qualidade de Código<br>
- Fastlane
- Slather
- Jazzy
- Swiftlint

#### Gerenciador de Dependências<br>

Gerenciadores usados: 
 - Swift Package Manager
 - Carthage

Dependências:
- [Kingfisher](https://github.com/onevcat/Kingfisher). Usando SPM (Download e cache de imagens).
- [Alamofire](https://github.com/Alamofire/Alamofire) Usando SPM (Realizaão de requisioes assincronas).
- [SwiftIconfont](https://github.com/segecey/SwiftIconFont) Usando Carthage (Ícones nos textos).


## Instruções para Execução de Projeto

Foi utilizado a versão do Ruby 2.7.0 no uso das ferramentas de gestão e qualidade.

---

## Configurando o Projeto

### [RVM](https://rvm.io/) e [BREW](https://brew.sh/)

Instale o RVM com o seguinte comando: <br>

```\curl -sSL https://get.rvm.io | bash -s stable```

Após a instalação, utilize o seguinte comando para usar a versão 2.7.0 do Ruby:

```
rvm install 2.7.0
```

Depois use o comando: <br>
```
rvm use 2.7.0
```

Instale o brew com o seguinte comando: <br>

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

---
### Instalando dependencias de Gestão

Após instalados o RVM com a versão indicada do Ruby, e a instalação do Brew, execute os seguintes comandos

```brew bundle```

Irá instalar as dependencias listadas no arquivo `Brewfile`.

Após a conclusão das instalaçoes feitas com brew, execute o comando a baixo para instalar as dependencias do Gemfile:

```bundle install```

---

### [XcodeGen](https://github.com/yonaskolb/XcodeGen)

<p>XcodeGen é uma ferramenta de linha de comando escrita em Swift que gera seu arquivo de projeto Xcode (project.pbxproj) usando sua estrutura de pastas e uma especificação de projeto.</p>

<p>A especificação do projeto é feita com um arquivo YAML ou JSON que define seus targets, configurações, schemes, configurações de builds personalizadas e muitas outras opções. Todos os seus diretórios de origem são automaticamente analisados e referenciados de forma apropriada, preservando sua estrutura de pastas. Configurações finas são usados em muitos lugares, portanto, você só precisa personalizar o que for necessário. Projetos muito complexos também podem ser definidos usando recursos mais avançados.</p>

 <p>Após renomear o projeto, execute o e instalar as dependencias, execute o comando em seu terminal:</p>

 ```bash
 xcodegen generate
 ```

---

### Instalação de Dependências do Projeto

No Xcode atualize as dependencias usando o Swift Package Manager

---

### Carthage

 Uma das dependencias do projeto está sendo gerenciada pelo Carthage. É possível gerar o build através do comando:

```
carthage update --cache-builds --platform ios
```

## Ferramentas

### Fastlane

Usado para automatizar tarefas como execucao de testes unitários, assinatura projetos e envio para Loja e Testflight.

No projeto, já possi alguns lanes básicos configurados. Para usa-los, execute um dos comandos abaixo:

- Check code style<br>
```fastlane ios lint_code```

- Create coverage report<br>
```fastlane ios coverage```

- Used by Development to keep code quality.<br>
```fastlane ios check_code``` ou ```fastlane check_code dev:true```

Ver mais no link: [Fastlane](https://fastlane.tools)

### Jazzy

Ferramenta para documentação de código

Ver mais no link: [Realm/jazzy](https://github.com/realm/jazzy)

### Slather

Ferramenta para exibir de forma mais amigável informações de cobertura de código do projeto.

Ver mais no link: [Slather](https://github.com/SlatherOrg/slather)