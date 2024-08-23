## Ambiente de Testes

A arquitetura do ambiente de testes é apresentada na Figura 1.

![Figura 1 - Arquitetura do Ambiente de Testes](assets/network.svg)

## Execução do Ambiente de Testes

Para executar o ambiente de testes, siga os passos a seguir:

1. Clone o repositório do projeto:

```bash
git clone https://gitlab.laspi.ufrj.br/laspi-rnd/bacen-interoperabilidade/testenv.git
```

2. Inicialize o ambiente de testes:

```bash
source run_env.sh
```

O script `run_env.sh` irá criar todos os containers necessários para a execução do ambiente de testes.

## Interrompendo a Execução do Ambiente de Testes

Para interromper a execução do ambiente de testes, basta executar o comando a seguir:

```bash
source stop_env.sh
```

O script `stop_env.sh` irá interromper a execução de todos os containers criados pelo script `run_env.sh`, além de remover os arquivos temporários.
