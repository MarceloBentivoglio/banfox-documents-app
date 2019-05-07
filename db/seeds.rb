ActiveRecord::Base.transaction do
  Document.destroy_all
  User.destroy_all

  user1 = User.create!(
    email: "joaquim@banfox.com.br",
    password: "123123",
    authentication_token: "dx3zDP3cY4FXs8qV12W3",
    admin: true,
  )

  variable_content1 = {
    seller: {
      company_name: "biort comercio de prod. medicos e cirúrgicos ltda.",
      cnpj: "08.588.244/0001-49",
      address: "rua dos meninos, 431 - nova gerty",
      city: "são caetano do sul",
      state: "SP",
      zip_code: "09580-300",
      email: "financeiro1@biortimplantes.com.br",
    },
    operation: {
      id: "1",
      time: "2019-04-29T10:30:00-03:00",
      gross_value: "16.905,33",
      fee: "62,41",
      net_value: "15.669,53",
      first_deposit: "13.524,26",
      protection: "3.381,06"
    },
    installments: [
      {
        payer_company_name: "belti comercio de produtos medicos",
        registration: "17.797.083/0001-94",
        type: "dmr",
        number: "006.609/01",
        due_date: "17/08/2018",
        outstanding_days: "27",
        value: "5.274,00",
        fee: "246,82",
        net_value: "5.003,52",
        first_deposit: "4.000,26",
        protection: "1.003,00"
      },
      {
        payer_company_name: "allianz saude sa",
        registration: "04.439.627/0001-02",
        type: "dmr",
        number: "006.632/01",
        due_date: "23/08/2018",
        outstanding_days: "33",
        value: "5.450,91",
        fee: "312,56",
        net_value: "5.112,90",
        first_deposit: "4.000,26",
        protection: "1.003,00"
      },
      {
        payer_company_name: "hospital santa paula",
        registration: "60.777.901/0001-16",
        type: "dmr",
        number: "006.638/01",
        due_date: "08/09/2018",
        outstanding_days: "49",
        value: "6.180,42",
        fee: "533,19",
        net_value: "5.615,53",
        first_deposit: "4.000,26",
        protection: "1.003,00"
      }
    ],
    signers: [
      {
        name: "joaquim primeiro devedor",
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

  puts "-----------------\n\n"
  puts "Seed created:"
  puts "User: #{user1.email}"
  puts "Password: #{user1.password}"
  puts "\n\n-----------------"
end

