## Ameaças e controles de segurança

| Componente | Ameaça | Consequência | Controle | Situação de implementação |
|---|---|---|---|---|
| Consulta de ativos | Código adulterado ou inválido | Retorno de um ativo incorreto ou inexistente | Validar o formato do código e verificar se o ativo existe antes de retornar os dados | Planejado ou implementado conforme o código |
| Cadastro e atualização de ativos | Envio de dados incorretos ou incompletos | Cadastro inconsistente e informações incorretas no sistema | Validar os campos obrigatórios, os tipos de dados e os valores recebidos pela API | Planejado ou implementado conforme o código |
| Registro de manutenção | Usuário sem autorização registrar ou alterar uma manutenção | Histórico de manutenção alterado indevidamente | Verificar a autorização do usuário antes de permitir o registro ou a alteração dos dados | Planejado ou implementado conforme o código |
| Login de usuários | Tentativa de acesso com credenciais inválidas ou roubadas | Acesso indevido aos dados dos ativos e às informações de manutenção | Validar as credenciais, armazenar senhas com hash seguro e limitar tentativas de login | Planejado ou implementado conforme o código |
| Cadastro de usuários | Envio de dados inválidos ou tentativa de criar contas indevidas | Cadastro de usuários com informações incorretas ou criação de contas não autorizadas | Validar os campos obrigatórios, verificar se o e-mail já está cadastrado e armazenar a senha com hash seguro | Planejado ou implementado conforme o código |
