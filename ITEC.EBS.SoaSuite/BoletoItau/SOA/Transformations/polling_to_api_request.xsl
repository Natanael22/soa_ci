<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/top/pollingBoletos"
                xmlns:mhdr="http://www.oracle.com/XSL/Transform/java/oracle.tip.mediator.service.common.functions.MediatorExtnFunction"
                xmlns:oraext="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.ExtFunc"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"
                xmlns:xref="http://www.oracle.com/XSL/Transform/java/oracle.tip.xref.xpath.XRefXPathFunctions"
                xmlns:socket="http://www.oracle.com/XSL/Transform/java/oracle.tip.adapter.socket.ProtocolTranslator"
                xmlns:oracle-xsl-mapper="http://www.oracle.com/xsl/mapper/schemas"
                xmlns:dvm="http://www.oracle.com/XSL/Transform/java/oracle.tip.dvm.LookupValue"
                xmlns:oraxsl="http://www.oracle.com/XSL/Transform/java"
                xmlns:tns="http://Edenred.Services/geradorBoletosItau_geradorBoletos_request"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="xsd oracle-xsl-mapper xsi xsl ns0 tns mhdr oraext xp20 xref socket dvm oraxsl"
                xmlns:plt="http://schemas.xmlsoap.org/ws/2003/05/partner-link/"
                xmlns:pc="http://xmlns.oracle.com/pcbpel/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                xmlns:jca="http://xmlns.oracle.com/pcbpel/wsdl/jca/"
                xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/ITEC.EBS.SoaSuite/BoletoItau/pollingBoletos"
                xmlns:plnk="http://docs.oasis-open.org/wsbpel/2.0/plnktype"
                xmlns:inp2="http://Edenred.Services/geradorBoletosItau_geradorBoletos_response"
                xmlns:ns2="http://xmlns.oracle.com/ITEC.EBS.ServiceBus/BoletoItau/geradorBoletosItau"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:inp3="http://Edenred.Services/geradorBoletosItau_geradorBoletos_validation_error">
                <!--xmlns:inp3="http://Edenred.Services/geradorBoletosItau_geradorBoletos_validation_error"
                xmlns:inp4="http://Edenred.Services/geradorBoletosItau_geradorBoletos_validation_422"
                xmlns:inp5="http://Edenred.Services/geradorBoletosItau_geradorBoletos_validation_token"-->
                
  <oracle-xsl-mapper:schema>
    <!--SPECIFICATION OF MAP SOURCES AND TARGETS, DO NOT MODIFY.-->
    <oracle-xsl-mapper:mapSources>
      <oracle-xsl-mapper:source type="WSDL">
        <oracle-xsl-mapper:schema location="../WSDLs/pollingBoletos.wsdl"/>
        <oracle-xsl-mapper:rootElement name="TktArBoletoRemessaCollection"
                                       namespace="http://xmlns.oracle.com/pcbpel/adapter/db/top/pollingBoletos"/>
      </oracle-xsl-mapper:source>
    </oracle-xsl-mapper:mapSources>
    <oracle-xsl-mapper:mapTargets>
      <oracle-xsl-mapper:target type="WSDL">
        <oracle-xsl-mapper:schema location="../WSDLs/geradorBoletosItau.wsdl"/>
        <oracle-xsl-mapper:rootElement name="Root-Element"
                                       namespace="http://Edenred.Services/geradorBoletosItau_geradorBoletos_request"/>
      </oracle-xsl-mapper:target>
    </oracle-xsl-mapper:mapTargets>
    <!--GENERATED BY ORACLE XSL MAPPER 12.2.1.2.0(XSLT Build 161003.0739.0018) AT [TUE AUG 07 18:17:25 BRT 2018].-->
  </oracle-xsl-mapper:schema>
  <!--User Editing allowed BELOW this line - DO NOT DELETE THIS LINE-->
  <xsl:template match="/">
    <tns:Root-Element>
      <!--1-para testes / 2-para produção-->
      <tns:tipo_ambiente>1</tns:tipo_ambiente>
      <tns:tipo_registro>1</tns:tipo_registro>
      <tns:tipo_cobranca>1</tns:tipo_cobranca>
      <tns:tipo_produto>00006</tns:tipo_produto>
      <tns:subproduto>00008</tns:subproduto>
      <tns:beneficiario>
        <tns:cpf_cnpj_beneficiario>
          <xsl:value-of select="translate (/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCnpjCedenBoletBanca,&quot;-/.,&quot;,&quot;&quot;)"/>  
        </tns:cpf_cnpj_beneficiario>
        <tns:agencia_beneficiario>
          <xsl:value-of select="translate (substring-before(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCedenBoletBanca,'/'),&quot; &quot;, &quot;&quot;)"/>
        </tns:agencia_beneficiario>
        <tns:conta_beneficiario>
          <xsl:variable name="contaBeneficiario"
                        select="substring-before(substring-after(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCedenBoletBanca,'/'),'-')"/>
          <xsl:value-of select="translate (format-number($contaBeneficiario,'#00000,00'), &quot;,.&quot;, &quot;&quot;)"/>
        </tns:conta_beneficiario>
        <tns:digito_verificador_conta_beneficiario>
          <xsl:value-of select="substring-after(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCedenBoletBanca,'-')"/>
        </tns:digito_verificador_conta_beneficiario>
      </tns:beneficiario>
      <tns:identificador_titulo_empresa>
        <xsl:value-of select="/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:documentId"/>
      </tns:identificador_titulo_empresa>
      <xsl:choose>
        <xsl:when test="/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdTipoAceitBoletBanca = 'SIM'">
          <tns:titulo_aceite>S</tns:titulo_aceite>
        </xsl:when>
        <xsl:otherwise>
          <tns:titulo_aceite>N</tns:titulo_aceite>
        </xsl:otherwise>
      </xsl:choose>
      <tns:pagador>
        <xsl:choose>
          <xsl:when test="contains (/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCgcCpfBoletBanca, 'CGC' )">
            <tns:cpf_cnpj_pagador>
              <xsl:variable name="cnpj"
                            select="substring-after(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCgcCpfBoletBanca, 'CGC')"/>
              <xsl:value-of select="translate ($cnpj,&quot; -/.,&quot;,&quot;&quot;)"/>
            </tns:cpf_cnpj_pagador>
          </xsl:when>
          <xsl:otherwise>
            <tns:cpf_cnpj_pagador>
              <xsl:variable name="cpf"
                            select="substring-after(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCgcCpfBoletBanca, 'CPF')"/>
              <xsl:value-of select="translate ($cpf,&quot; -/.,&quot;,&quot;&quot;)"/>
            </tns:cpf_cnpj_pagador>
          </xsl:otherwise>
        </xsl:choose>
        <tns:nome_pagador>
          <xsl:value-of select="substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:nmSacadBoletBanca,1,30)"/>
        </tns:nome_pagador>
        <tns:logradouro_pagador>
          <xsl:value-of select="translate (substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dsEnderSacadBoletBanca,1,40),&quot;-/.,&quot;,&quot;&quot;)"/>
        </tns:logradouro_pagador>
        <tns:bairro_pagador>
          <xsl:value-of select="substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dsBairrSacadBoletBanca,1,15)"/>
        </tns:bairro_pagador>
        <tns:cidade_pagador>
          <xsl:value-of select="substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dsCidadSacadBoletBanca,1,20)"/>
        </tns:cidade_pagador>
        <tns:uf_pagador>
          <xsl:value-of select="/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:sgUfSacadBoletBanca"/>
        </tns:uf_pagador>
        <tns:cep_pagador>
          <xsl:value-of select="translate (substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdCepSacadBoletBanca,1,8),&quot;áâãàéêíõóôúüçÁÂÃÀÉÊÍÕÓÔÚÜÇ¿ºª´`^~¨|'&quot;, &quot;aaaaeeiooouucAAAAEEIOOOUUC&quot;)"/>
        </tns:cep_pagador>
      </tns:pagador>
      <tns:tipo_carteira_titulo>
        <xsl:value-of select="normalize-space (substring-before(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdNossoNumerBoletBanca,'/') )"/>
      </tns:tipo_carteira_titulo>
      <tns:moeda>
        <xsl:choose>
          <xsl:when test="/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dsEspecBoletBanca = 'R$'">
            <tns:codigo_moeda_cnab>09</tns:codigo_moeda_cnab>
          </xsl:when>
          <xsl:otherwise>
            <tns:codigo_moeda_cnab/>
          </xsl:otherwise>
        </xsl:choose>
      </tns:moeda>
      <tns:nosso_numero>
        <xsl:value-of select="substring-after(substring-before(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdNossoNumerBoletBanca,'-'),'/')"/>
      </tns:nosso_numero>
      <tns:digito_verificador_nosso_numero>
        <xsl:value-of select="substring-after(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:cdNossoNumerBoletBanca,'-')"/>
      </tns:digito_verificador_nosso_numero>      
      <tns:data_vencimento>
        <xsl:value-of select="concat(substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dtVenciBoletBanca,7,4),'-',
                                          substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dtVenciBoletBanca,4,2),'-',
                                          substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dtVenciBoletBanca,1,2))"/>
      </tns:data_vencimento>
      <tns:valor_cobrado>
        <xsl:if test='string-length(translate (/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlDocumBoletBanca, ",.", "" )&lt; 17 )'>
          <xsl:variable name="valorCobrado"
                        select="translate (/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlDocumBoletBanca, ',.', '' )"/>
          <xsl:value-of select="translate (format-number($valorCobrado,'#000000000000000,00'), &quot;,.&quot;, &quot;&quot;)"/>
        </xsl:if>
      </tns:valor_cobrado>
      <tns:seu_numero>
        <xsl:value-of select="substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:nrDocumBoletBanca,1,10)"/>
      </tns:seu_numero>
      <!-- SOMENTE DUPLICATA -->
      <tns:especie>08</tns:especie>
      
      <tns:data_emissao>
        <xsl:value-of select="concat(substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dtDocumBoletBanca,7,4),'-',
                                          substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dtDocumBoletBanca,4,2),'-',
                                          substring(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:dtDocumBoletBanca,1,2))"/>
      </tns:data_emissao>
      <!-- PREENCHER DATA DE VENCIMENTO -->
      <tns:tipo_pagamento>3</tns:tipo_pagamento>
      <tns:indicador_pagamento_parcial>false</tns:indicador_pagamento_parcial>
      <tns:juros>
      <xsl:choose>
          <xsl:when test="/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlJurosDia = 0 or /ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlJurosDia = ''">
            <tns:tipo_juros>5</tns:tipo_juros>
            <tns:valor_juros>0</tns:valor_juros>
          </xsl:when>
          <xsl:otherwise>            
            <tns:tipo_juros>3</tns:tipo_juros>
            <tns:percentual_juros>
              <xsl:if test='string-length(translate (/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlJurosDia, ",.", "" )&lt; 17 )'>                                
                <xsl:value-of select="translate (format-number(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlJurosDia,'#0000000.00000'), &quot;,.&quot;, &quot;&quot;)"/> 
              </xsl:if>
            </tns:percentual_juros>
          </xsl:otherwise>
      </xsl:choose>        
      </tns:juros>
      <tns:multa>
      <xsl:choose>
          <xsl:when test="/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlMoraDia = 0 or /ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlMoraDia = ''">
            <tns:tipo_multa>3</tns:tipo_multa>
            <tns:valor_multa>0</tns:valor_multa>
          </xsl:when>
          <xsl:otherwise>            
            <tns:tipo_multa>2</tns:tipo_multa>
            <tns:percentual_multa>
              <xsl:if test='string-length(translate (/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlMoraDia, ",.", "" )&lt; 17 )'>              
              <xsl:value-of select="translate (format-number(/ns0:TktArBoletoRemessaCollection/ns0:TktArBoletoRemessa/ns0:vlMoraDia,'#0000000.00000'), &quot;,.&quot;, &quot;&quot;)"/>          
            </xsl:if>          
            </tns:percentual_multa>
          </xsl:otherwise>
      </xsl:choose>
      </tns:multa>
      <tns:grupo_desconto>
        <tns:tipo_desconto>0</tns:tipo_desconto>        
      </tns:grupo_desconto>
      <tns:recebimento_divergente>
        <tns:tipo_autorizacao_recebimento>3</tns:tipo_autorizacao_recebimento>
      </tns:recebimento_divergente>
    </tns:Root-Element>
  </xsl:template>
</xsl:stylesheet>
