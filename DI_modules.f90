!!! modules for dependency injection demo!!!

module DI_service
  implicit none

  private
  public service_interface, serviceA, serviceB

  ! first want an interface (in the non-fortran manner)
  type, abstract :: service_interface
    contains
      ! use the deferred statement (akin to making a C++ function pure virtual)
      procedure(interface_useService), deferred :: useService 
  end type service_interface

  ! interface (in the fortran manner) for the virtual method
  ! declare subroutine outline as interface
  interface 
    subroutine interface_useService(self)
      import
      class(service_interface), intent(in) :: self
      end subroutine interface_useService 
  end interface 

  ! services which extend the interface (in the non-fortran manner)
  type, extends(service_interface) :: serviceA
    contains 
      procedure :: useService => useA
  end type serviceA

  type, extends(service_interface) :: serviceB
    contains
      procedure :: useService => useB
  end type serviceB

  ! implementation of the service methods
  contains
    subroutine useA(self)
      class(serviceA), intent(in) :: self
      print *, 'serviceA used'
    end subroutine

    subroutine useB(self)
      class(serviceB), intent(in) :: self
      print *, 'serviceB used'
    end subroutine 

end module DI_service

module DI_client
  use DI_service
  implicit none

  private
  public client 

  ! declare the client type
  type :: client
    class(service_interface), pointer :: service
    contains
      procedure :: setService
      procedure :: doSomething
  end type client

  contains
    ! injector -> assign a service to the client
    subroutine setService(self, service)
      class(client), intent(inout) :: self
      class(service_interface), pointer, intent(in) :: service
      ! assign via function pointer
      self%service => service
    end subroutine setService

    ! method to use the injected service
    subroutine doSomething(self)
      class(client), intent(in) :: self      
      call self%service%useService()
    end subroutine dosomething

end module DI_client
