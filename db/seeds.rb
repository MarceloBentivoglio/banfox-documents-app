ActiveRecord::Base.transaction do
  Document.destroy_all
  User.destroy_all

  user1 = User.create!(
    email: "joaquim@banfox.com.br",
    password: "123123",
    admin: true,
  )

  variable_content1 = {
    seller: {
      company_name: "BIORT COMÉRCIO DE PROD. MÉDICOS E CIRÚRGICOS LTDA.",
      cnpj: "08.588.244/0001-49",
      address: "RUA DOS MENINOS, 431 - NOVA GERTY",
      city: "São Caetano do Sul",
      state: "SP",
      zip_code: "09580-300",
      email: "financeiro1@biortimplantes.com.br",
    },
    operation: {
      id: "1",
      time: "2019-04-29T10:30:00-03:00",
      gross_value: "16.905,33",
      fator: "1.071,73",
      advalorem: "20,84",
      iof: "20,65",
      iof_adicional: "60,17",
      fee: "62,41",
      net_value: "15.669,53",
    },
    installments: [
      {
        payer_company_name: "BELTI COMERCIO DE PRODUTOS MEDICOS",
        registration: "17.797.083/0001-94",
        type: "DMR",
        invoice_number: "6609",
        number: "006.609/01",
        due_date: "17/08/2018",
        outstanding_days: "27",
        value: "5.274,00",
        fator_advalorem: "246,82",
        iof: "23,66",
        net_value: "5.003,52"
      },
      {
        payer_company_name: "ALLIANZ SAUDE SA",
        registration: "04.439.627/0001-02",
        type: "DMR",
        invoice_number: "6632",
        number: "006.632/01",
        due_date: "23/08/2018",
        outstanding_days: "33",
        value: "5.450,91",
        fator_advalorem: "312,56",
        iof: "25,45",
        net_value: "5.112,90",
      },
      {
        payer_company_name: "HOSPITAL SANTA PAULA",
        registration: "60.777.901/0001-16",
        type: "DMR",
        invoice_number: "6638",
        number: "006.638/01",
        due_date: "08/09/2018",
        outstanding_days: "49",
        value: "6.180,42",
        fator_advalorem: "533,19",
        iof: "31,70",
        net_value: "5.615,53"
      }
    ],
    signers: [
      {
        name: "Joaquim Primeiro Devedor",
        birthdate: "1989-04-21",
        mobile: "11998308090",
        documentation: "096.701.336-45",
        email: "joaquim.oliveira.nt@gmail.com",
        sign_as: ["sign", "joint_debtor"]
      }
    ]

  }

  document1 = Document.create!(
    user: user1,
    variable_content: variable_content1,
  )
end

