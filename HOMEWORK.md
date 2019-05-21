# RSpec - Framework de testing Ruby

## Estructura de carpetas sugerida

- `spec/`: Raíz de tests de aplicación.
  - `spec/factories/`: Carpeta de definición de `factories` de datos, para lo cual se utiliza `FactoryBot`.
  - `spec/controllers/`: Carpeta de definición de tests de controladores.
  - `spec/models/`: Carpeta de definición de tests de modelos.
  - `spec/services/`: Carpeta de definición de tests de servicios.
  - `spec/rails_helper.rb`: Archivo de configuración de tests de Rails.
  - `spec/spec_helper.rb`: Archivo de configuración de RSpec.

## Homework

### Parte 1

#### RSpec en Ruby

1. Analizar funcionamiento de `ApiLoginManager` (`app/services/api_login_manager.rb`), servicio que permite realizar la autenticación de un usuario a través de una API. Recibe como parámetros el email y la contraseña y, en caso de ser correctos, retorna un token de autenticación. En caso contrario, retorna `false` y en un getter `error` almacena el mensaje de error. Tener en cuenta que hace un llamado (falso, ya que en realidad es una simulación) a un validador externo representado por `ExternalValidator`, el cual puede ser *stubbeado* en los tests.
2. Abrir archivo `spec/services/api_login_manager_spec.rb` e implementar tests para la clase `ApiLoginManager` (`app/services/api_login_manager.rb`). Analizar esquelo de test propuesto.

#### RSpec en Rails

1. Abrir modelos `User` (`app/models/user.rb`) y `Post` (`app/models/post.rb`). Analizar relaciones, validaciones, asociaciones y métodos.
2. Abrir tests de modelos en `spec/models/`. El esqueleto del test de `User` está implementado: implementar los tests según comentarios agregados en el código (`spec/models/user_spec.rb`).
3. Implementar tests de modelo `Post` (`spec/models/post_spec.rb`).

---

Una vez finalizadas las implementaciones, **realizar un pull request al repositorio principal desde un fork** para la corrección de implementación (opcional, pero recomendable).

### Parte 2

*Por definir.*
