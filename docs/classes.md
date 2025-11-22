# Diagrama de classes

``` mermaid
classDiagram
    direction LR

    %% --- Entidades Principais e Relacionamentos ---
    User "1" -- "1..*" Ocupante : "é um"
    Republica "1" -- "1..*" Ocupante : "possui"
    Republica "1" -- "0..*" Despesa : "contém"
    Despesa "1" -- "1" Categoria : "pertence a"
    Despesa "1" -- "0..1" Subcategoria : "detalhada por"
    Categoria "1" -- "0..*" Subcategoria : "agrupa"


    %% --- Módulo de Autenticação e Usuários ---
    class User {
        +id: string
        +email: string
        +password: string
        +role: UserRole (DONO | OCUPANTE)
    }

    class AuthController {
        +AuthService: authService
        +login(dto: LoginDto)
        +register(dto: RegisterDto)
    }

    class AuthService {
        +UserService: userService
        +JwtService: jwtService
        +validateUser(email, pass): Promise~User~
        +login(user: User): Promise~LoginResponseDto~
    }
    
    class LoginResponseDto {
        +access_token: string
    }


    %% --- Módulo de Gestão da República e Ocupantes ---
    class Republica {
        +id: string
        +nome: string
        +endereco: string
        +numQuartos: int
    }

    class Ocupante {
        +id: string
        +rendaMensal: float
    }

    class RepublicaController {
        +RepublicaService: republicaService
        +create(dto: CreateRepublicaDto)
        +addOcupante(republicaId, dto: AddOcupanteDto)
        +listOcupantes(republicaId)
        +updateOcupante(ocupanteId, dto: UpdateOcupanteDto)
        +removeOcupante(ocupanteId)
    }

    class RepublicaService {
        +RepublicaRepository: republicaRepository
        +OcupanteRepository: ocupanteRepository
        +create(data): Promise~Republica~
        +addOcupante(republicaId, data)
        ...
    }

    class CreateRepublicaDto {
        +nome: string
        +endereco: string
    }

    class AddOcupanteDto {
        +email: string
        +nome: string
        +rendaMensal: float
    }

    class UpdateOcupanteDto {
        +rendaMensal?: float
    }

    RepublicaController --|> RepublicaService : Injeta
    RepublicaController ..> CreateRepublicaDto : Usa
    RepublicaController ..> AddOcupanteDto : Usa
    RepublicaController ..> UpdateOcupanteDto : Usa
    RepublicaService ..> Republica : Manipula
    RepublicaService ..> Ocupante : Manipula


    %% --- Módulo de Despesas ---
    class Despesa {
        +id: string
        +descricao: string
        +valor: float
        +data: Date
    }
    class Categoria {
      +id: string
      +nome: string
    }
    class Subcategoria {
      +id: string
      +nome: string
    }

    class DespesaController {
        +DespesaService: despesaService
        +create(dto: CreateDespesaDto)
        +findAll(filters: QueryFilterDto)
    }

    class DespesaService {
        +DespesaRepository: despesaRepository
        +create(data): Promise~Despesa~
        +findAll(filters): Promise~Despesa[]~
    }

    class CreateDespesaDto {
        +descricao: string
        +valor: float
        +data: Date
        +categoriaId: string
        +subcategoriaId?: string
    }

    DespesaController --|> DespesaService : Injeta
    DespesaController ..> CreateDespesaDto : Usa
    DespesaService ..> Despesa : Manipula


    %% --- Módulo de Relatórios (Lógica de Negócio) ---
    class RelatorioController {
        +RelatorioService: relatorioService
        +gerarRelatorio(dto: GenerateRelatorioDto)
        +exportarRelatorio(reportId)
    }

    class RelatorioService {
        -DespesaService: despesaService
        -OcupanteService: ocupanteService
        +gerarDivisao(options): Promise~RelatorioView~
        -calcularDivisaoIgualitaria(despesas, ocupantes)
        -calcularDivisaoProporcional(despesas, ocupantes)
    }

    class GenerateRelatorioDto {
        +dataInicio: Date
        +dataFim: Date
        +metodoDivisao: Metodo (IGUALITARIA | PROPORCIONAL)
        +despesasExcluidasIds?: string[]
    }

    RelatorioController --|> RelatorioService : Injeta
    RelatorioController ..> GenerateRelatorioDto : Usa
    RelatorioService --|> DespesaService : Depende de
    RelatorioService --|> RepublicaService : Depende de


    %% --- Módulo do Dashboard (Visualização de Dados) ---
    class DashboardController {
        +DashboardService: dashboardService
        +getResumoMensal(republicaId)
        +getDespesasPorCategoria(republicaId)
    }

    class DashboardService {
        -DespesaService: despesaService
        +calcularResumo(republicaId): Promise~Resumo~
        +calcularGastosPorCategoria(republicaId): Promise~ChartData~
    }

    DashboardController --|> DashboardService : Injeta
    DashboardService --|> DespesaService : Depende de
```