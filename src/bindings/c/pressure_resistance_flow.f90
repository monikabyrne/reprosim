module pressure_resistance_flow_c
implicit none
private

contains


!
!###################################################################################
!
!*calculate_stats:* Calculates statistics for the feto-placental circulation model
  subroutine calculate_stats_c() bind(C, name="calculate_stats_c")
    use pressure_resistance_flow, only: calculate_stats
    implicit none

#if defined _WIN32 && defined __INTEL_COMPILER
    call so_calculate_stats
#else
    call calculate_stats
#endif

  end subroutine calculate_stats_c

!
!###################################################################################
!


!!!###################################################################################

subroutine evaluate_prq_c(mesh_type,mesh_type_len,bc_type,bc_type_len,inlet_flow, &
               inlet_pressure,outlet_pressure) bind(C, name="evaluate_prq_c")

use iso_c_binding, only: c_ptr
use utils_c, only: strncpy
use other_consts, only: MAX_STRING_LEN
use arrays, only: dp
use pressure_resistance_flow, only: evaluate_prq
implicit none

type(c_ptr), value, intent(in) :: mesh_type,bc_type
integer,intent(in) :: mesh_type_len,bc_type_len
character(len=MAX_STRING_LEN) :: mesh_type_f,bc_type_f
real(dp),intent(in) :: inlet_flow,inlet_pressure,outlet_pressure

call strncpy(mesh_type_f, mesh_type, mesh_type_len)
call strncpy(bc_type_f, bc_type, bc_type_len)

#if defined _WIN32 && defined __INTEL_COMPILER
call so_evaluate_prq(mesh_type_f,bc_type_f,inlet_flow,inlet_pressure,outlet_pressure)
#else
call evaluate_prq(mesh_type_f,bc_type_f,inlet_flow,inlet_pressure,outlet_pressure)
#endif

end subroutine evaluate_prq_c

!###################################################################################
end module pressure_resistance_flow_c
