# Controle de Abastecimento de Veículos
- Bem-vindo ao sistema de Controle de Abastecimento de Veículos! Este aplicativo foi desenvolvido para ajudar os usuários a gerenciar seus veículos e acompanhar o histórico de abastecimentos de maneira eficiente.

## Funcionalidades
- Cadastro de Veículos: Adicione, edite e exclua informações dos seus veículos.

- Registro de Abastecimentos: Adicione, edite e exclua abastecimentos de veículos, acompanhando a quilometragem e o consumo de combustível.

- Cálculo de Média de Consumo: Calcule e exiba a média de km/l para cada veículo com base nos abastecimentos registrados.

- Autenticação de Usuários: Funcionalidades de login e registro de usuários para garantir a segurança dos dados.

- Notificações de Erro: Mensagens de erro intuitivas para facilitar a interação do usuário com o sistema.

## Tecnologias Utilizadas
- Flutter: Framework utilizado para desenvolvimento do aplicativo móvel.

- Firebase: Serviço backend utilizado para autenticação e armazenamento de dados.

- Firebase Auth: Gerenciamento de autenticação de usuários.

- Cloud Firestore: Banco de dados NoSQL em tempo real.

## Instalação
### Pré-requisitos
- Flutter instalado no seu ambiente de desenvolvimento.

- Firebase CLI para configuração do Firebase.

## Estrutura do Projeto
- main.dart: Ponto de entrada do aplicativo.

- screens/: Contém todas as telas do aplicativo, como home_screen.dart, login_screen.dart, register_screen.dart, novo_abastecimento_screen.dart, meus_veiculos_screen.dart, editar_veiculo_screen.dart.

- widgets/: Contém widgets reutilizáveis como o drawer_widget.dart.

## Como Usar
### Adicionar um Veículo
- Navegue até a tela "Meus Veículos".

- Clique no botão "Adicionar Veículo".

- Preencha as informações do veículo e clique em "Adicionar".

### Registrar um Abastecimento
- Navegue até a tela "Meus Veículos".

- Selecione um veículo.

- Clique no botão "Registrar Abastecimento".

- Preencha as informações do abastecimento e clique em "Registrar".

### Editar ou Excluir um Veículo
- Navegue até a tela "Meus Veículos".

- Clique no ícone de edição ou exclusão ao lado do veículo desejado.

### Editar ou Excluir um Abastecimento
- Navegue até a tela "Histórico de Abastecimentos".

- Clique no ícone de edição ou exclusão ao lado do abastecimento desejado.