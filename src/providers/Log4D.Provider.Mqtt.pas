unit Log4D.Provider.Mqtt;

interface

uses
  System.SysUtils,
  IdTCPClient,
  Log4D,
  Log4D.Provider,
  Log4D.Provider.Param.Mqtt,
  System.Classes, IdGlobal;

type
  TLog4DProviderMqtt = class(TInterfacedObject,ILog4DProvider)
  private
    FParams: TLog4DProviderParamMqtt;
    function CreateMQTTHeader: TBytes;
  public
    constructor Create(AParams: TLog4DProviderParamMqtt);
    procedure Send(AMessage: string);
  end;

implementation

{ TLog4DProviderTextFile }

constructor TLog4DProviderMqtt.Create(AParams: TLog4DProviderParamMqtt);
begin
  FParams := AParams;
end;


procedure TLog4DProviderMqtt.Send(AMessage: string);
var
  TCPClient: TIdTCPClient;
  MQTTData: TIdBytes;
begin
  TCPClient := TIdTCPClient.Create(nil);
  try
    TCPClient.Host := FParams.Broker;
    TCPClient.Port := FParams.Port;

    try
      TCPClient.Connect;

      // Montar pacote MQTT CONNECT
      // Formato: | Fixed Header (0x10) | Remaining Length | Protocol Name | Protocol Level | Connect Flags | Keep Alive |
      SetLength(MQTTData, 0);

      // Fixed Header (CONNECT = 0x10)
      AppendByte(MQTTData, $10);

      // Remaining Length (calculado depois)
      AppendByte(MQTTData, 0);

      // Protocol Name (MQTT)
      AppendByte(MQTTData, 0); // Length MSB
      AppendByte(MQTTData, 4); // Length LSB
      AppendString(MQTTData, 'MQTT');

      // Protocol Level (4 = MQTT 3.1.1)
      AppendByte(MQTTData, $04);

      // Connect Flags (Clean Session = 1)
      AppendByte(MQTTData, $02);

      // Keep Alive (60 segundos)
      AppendByte(MQTTData, 0);
      AppendByte(MQTTData, 60);

      // Client ID (pode ser vazio para Clean Session=1)
      AppendByte(MQTTData, 0);
      AppendByte(MQTTData, 0);

      // Atualizar Remaining Length
      MQTTData[1] := Length(MQTTData) - 2;

      // Enviar pacote CONNECT
      TCPClient.IOHandler.Write(MQTTData);

      // Esperar CONNACK (2 bytes)
      TCPClient.IOHandler.ReadBytes(MQTTData, 2, False);


      // Montar pacote PUBLISH
      SetLength(MQTTData, 0);

      // Fixed Header (PUBLISH = 0x30, QoS 0)
      AppendByte(MQTTData, $30);

      // Remaining Length (calculado depois)
      AppendByte(MQTTData, 0);

      // Topic Name
      AppendByte(MQTTData, 0); // Length MSB
      AppendByte(MQTTData, 5); // Length LSB
      AppendString(MQTTData, FParams.Topic);

      // Message
      AppendString(MQTTData, AMessage);

      // Atualizar Remaining Length
      MQTTData[1] := Length(MQTTData) - 2;

      // Enviar pacote PUBLISH
      TCPClient.IOHandler.Write(MQTTData);
    except on e:exception do
      TLog4D.Error(e.Message,false);
    end
  finally
    TCPClient.Free;
  end;
end;

function TLog4DProviderMqtt.CreateMQTTHeader: TBytes;
begin
  Result := TBytes.Create($10, 0, 0, 4, $00, $04,
    Ord('M'), Ord('Q'), Ord('T'), Ord('T'));
end;

end.
