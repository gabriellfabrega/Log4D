# Log4D - Sistema de Logs Distribuído para Delphi

![Delphi](https://img.shields.io/badge/Delphi-7%20to%2012.3-blue)

> **Log4D** surgiu da necessidade de gerenciar logs de aplicações distribuídas. Com ele, é possível visualizar os logs em tela, armazená-los e trafegá-los por diversos meios.

## Recursos
✅ **APIs**  
✅ **Filas MQTT**  
✅ **Arquivos de Texto**  
✅ **Banco de Dados SQLite**  

---

## 🚀 Instalação

Adicione **Log4D** ao seu projeto com o [Boss](https://github.com/HashLoad/boss):

```bash
boss install https://github.com/gabriellfabrega/Log4D
```

---

## 📌 Como Usar

### 1️⃣ Adicione a Unit ao Seu Projeto

```delphi
uses
  Log4D;
```

### 2️⃣ Configure os Providers (opcional)

Caso deseje criar uma *Factory* para os providers:

```delphi
class function TLog4DSampleFactoryProviders.CreateMqttProvider: TLog4DProviderMqtt;
var
  LParams: TLog4DProviderParamMqtt;
begin
  LParams.Broker := '127.0.0.1';
  LParams.Port := 1883;
  LParams.Topic := '/logs';
  Result := TLog4DProviderMqtt.Create(LParams);
end;
```

### 3️⃣ Inicialização com os Providers Desejados

```delphi
TLog4D
  .Output(Memo1)
  .UseProvider(TLog4DSampleFactoryProviders.CreateTextFileProvider)
  .UseProvider(TLog4DSampleFactoryProviders.CreateHttpProvider)
  .UseProvider(TLog4DSampleFactoryProviders.CreateMqttProvider)
  .UseProvider(TLog4DSampleFactoryProviders.CreateSqliteProvider);
```

### 4️⃣ Registro de Logs

```delphi
begin
  TLog4D.Debug('Exemplo Debug');
  TLog4D.Trace('Exemplo Trace');
  TLog4D.Warn('Exemplo Warn');
  TLog4D.Info('Exemplo Info');
  TLog4D.Error('Exemplo Error');
end;
```

---

## 🔌 Criando um Novo Provider

Para adicionar um novo provider, basta implementar a interface:

```delphi
unit Log4D.Provider;

interface

type
  ILog4DProvider = interface
    ['{430EC143-E250-4803-8CEF-17FB0D8AC947}']
    procedure Send(AMessage: string);
  end;

implementation

end.
```

---

## 🎯 Contribuição
Fique à vontade para enviar *Pull Requests* e sugerir melhorias! 🚀

---

### 📜 Licença
Este projeto está licenciado sob a **MIT License**.
