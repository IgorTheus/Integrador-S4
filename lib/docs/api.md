## Endpoints da API

| Método | Endpoint | Operação |
|---|---|---|
| `GET` | `/api/ativos/{codigo}` | Consultar ativo por código |
| `GET` | `/api/ativos` | Listar ativos |
| `POST` | `/api/ativos` | Cadastrar ativo |
| `PUT` | `/api/ativos/{id}` | Atualizar dados do ativo |
| `PATCH` | `/api/ativos/{id}/localizacao` | Atualizar localização |
| `GET` | `/api/ativos/{id}/manutencoes` | Consultar histórico |
| `POST` | `/api/ativos/{id}/manutencoes` | Registrar manutenção |
| `GET` | `/api/ativos/qr/{codigo}` | Consultar por QR Code |
| `GET` | `/api/ativos?localizacao={local}` | Filtrar por localização |
| `GET` | `/api/usuarios` | Consultar usuários autorizados |
| `PATCH` | `/api/ativos/{id}/status` | Desativar ativo |
