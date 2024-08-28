#include 'totvs.ch'
#include 'fwmvcdef.ch'

/*/{Protheus.doc} TEST
(long_description)
@type user function
@author Aencio
@since 01/03/2024
@version 1.0
/*/
User Function TEST()

    Private aRotina   := menudef()
    Private oBrowse   := fwMBrowse():New()

    oBrowse:setAlias('ZSB')
    oBrowse:setDescription('Cadastro prestação de contas')
    oBrowse:setExecuteDef(4)
    //Browse:setFilterDefault("RETCODUSR() == GETMV('MZ_APRPC') .OR. ZSB->(ZSB_CODSOL) = RETCODUSR()")
    //oBrowse:setFilterDefault("RETCODUSR() != GETMV('MZ_APRPC') .OR. ZSB->(ZSB_STATUS) != 'EAB'")        
    // oBrowse:AddLegend("ZSB_STATUS == 'EAB' ", "BR_BRANCO"    ,"Em Aberto")
    // oBrowse:AddLegend("ZSB_STATUS == 'EFT' ", "BR_VERDE"     ,"Efetivado")
    // oBrowse:AddLegend("ZSB_STATUS == 'RVS' ", "BR_AMARELO"   ,"Revisão")
    // oBrowse:AddLegend("ZSB_STATUS == 'CAN' ", "BR_CINZA"     ,"Cancelado")
    // oBrowse:AddLegend("ZSB_STATUS == 'APR' ", "BR_VERMELHO"  ,"Aprovado")
    oBrowse:activate()
Return

/*/{Protheus.doc} menudef
(long_description)
@type user function
@author Aencio 
@since 01/03/2024
@version 1.0
/*/
Static Function menudef()

    Local aRotina := {}
    //adicionando itens ao menu
    ADD OPTION ARotina TITLE 'Pesquisar'  ACTION 'AxPesqui'     OPERATION 1 ACCESS 0
    ADD OPTION ARotina TITLE 'Visualizar' ACTION 'VIEWDEF.TEST' OPERATION 2 ACCESS 0
    ADD OPTION ARotina TITLE 'Incluir'    ACTION 'VIEWDEF.TEST' OPERATION 3 ACCESS 0
    ADD OPTION ARotina TITLE 'Alterar'    ACTION 'VIEWDEF.TEST' OPERATION 4 ACCESS 0
    //ADD OPTION aRotina TITLE 'Legenda'    ACTION 'U_LEGEND()'   OPERATION 6 ACCESS 0

Return aRotina

/*/{Protheus.doc} viewdef
(loAEng_description)
@type Static function
@author Aencio
@since 01/03/2024
@version 1.0
/*/

Static Function viewdef()
    Local oView
    Local oModel
    Local oStruct

    oStruct := FWFormStruct(2, 'ZSB')
    oModel  := FwLoadModel('TEST')
    oView   := FWFormView():new()

    oView:setModel(oModel)
    oView:addField('ZSBMASTER',oStruct,'ZSBMASTER')
    oView:createHorizontalBox('BOXZSB',100)
    oView:setOwnerView('ZSBMASTER','BOXZSB')

Return oView

/*/{Protheus.doc} modeldef
(Construção da regra de negocio)
@type Static function
@author Aencio
@since  01/03/2024
@version 1.0
/*/
Static Function modeldef()

    Local oModel
    Local oStruct
    Local bFieldPos := {|oModel| ADDSTATUS(oModel)}
    Local bModelPos := {|x| fnModPos(x)}

    oStruct := FWFormStruct(1,'ZSB') 
    oModel := mpFormModel():new('MODEL_TEST') 
    oModel:addFields('ZSBMASTER',,oStruct,bFieldPos,bModelPos)
    oModel:setDescription('Tipos de contratos')
    oModel:setPrimaryKey({'ZSB_FILIAL', 'ZSB_ID'})

Return oModel

/*/{Protheus.doc} ADDSTATUS
(Construção da regra de negocio)
@type User function
@author Aencio
@since  01/03/2024
@version 1.0
/*/

// Static Function ADDSTATUS(oModel)
//     local nOpr := oModel:getOperation()
//     Local cStatus

//      IF nOpr == 3
//         cStatus := "EAB"
//         oModel:LoadValue('ZSB_STATUS',cStatus)
//     EndIF
// Return 
