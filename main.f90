!!! Test implementation of Dependency Injection !!!

program main
  use DI_service
  use DI_client
  implicit none
  
  ! create the client
  type(client) :: clientObject
  ! create the services
  class(serviceA), pointer :: firstService
  class(serviceB), pointer :: secondService
  ! allocate services
  allocate(firstService)
  allocate(secondService)
  ! inject the first service
  call clientObject%setService(firstService)
  ! use the service
  call clientObject%doSomething()
  ! inject the second service
  call clientObject%setService(secondService)
  ! use the service
  call clientObject%doSomething()
  ! all done :-)

end program
