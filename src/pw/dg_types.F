!--------------------------------------------------------------------------------------------------!
!   CP2K: A general program to perform molecular dynamics simulations                              !
!   Copyright 2000-2022 CP2K developers group <https://cp2k.org>                                   !
!                                                                                                  !
!   SPDX-License-Identifier: GPL-2.0-or-later                                                      !
!--------------------------------------------------------------------------------------------------!

! **************************************************************************************************
!> \par History
!>      none
! **************************************************************************************************
MODULE dg_types

   USE dg_rho0_types,                   ONLY: dg_rho0_create,&
                                              dg_rho0_release,&
                                              dg_rho0_type
#include "../base/base_uses.f90"

   IMPLICIT NONE

! Information on the assignment function for Ewald
! **************************************************************************************************
   TYPE dg_type
      PRIVATE
      INTEGER :: grid_index
      TYPE(dg_rho0_type), POINTER :: dg_rho0
   END TYPE dg_type

! **************************************************************************************************
   TYPE dg_p_type
      TYPE(dg_type), POINTER :: dg
   END TYPE dg_p_type

   CHARACTER(len=*), PARAMETER, PRIVATE :: moduleN = 'dg_types'

   PRIVATE
   PUBLIC :: dg_type, dg_get, &
             dg_set, dg_release, &
             dg_create

CONTAINS

! **************************************************************************************************
!> \brief   Get the dg_type
!> \param dg ...
!> \param grid_index ...
!> \param dg_rho0 ...
!> \version 1.0
! **************************************************************************************************
   SUBROUTINE dg_get(dg, grid_index, dg_rho0)
      TYPE(dg_type), POINTER                             :: dg
      INTEGER, OPTIONAL                                  :: grid_index
      TYPE(dg_rho0_type), OPTIONAL, POINTER              :: dg_rho0

      IF (PRESENT(grid_index)) grid_index = dg%grid_index
      IF (PRESENT(dg_rho0)) dg_rho0 => dg%dg_rho0

   END SUBROUTINE dg_get

! **************************************************************************************************
!> \brief   create the dg structure
!> \param dg ...
!> \version 1.0
! **************************************************************************************************
   SUBROUTINE dg_create(dg)
      TYPE(dg_type), INTENT(OUT)                         :: dg

      CALL dg_rho0_create(dg%dg_rho0)

   END SUBROUTINE dg_create

! **************************************************************************************************
!> \brief releases the given dg_type
!> \param dg the dg_type to release
!> \par History
!>      04.2003 created [fawzi]
!> \author fawzi
!> \note
!>      see doc/ReferenceCounting.html
! **************************************************************************************************
   SUBROUTINE dg_release(dg)
      TYPE(dg_type), INTENT(INOUT)                       :: dg

      CALL dg_rho0_release(dg%dg_rho0)
   END SUBROUTINE dg_release

! **************************************************************************************************
!> \brief   Set the double grid environment
!> \param dg ...
!> \param dg_rho0 ...
!> \param grid_index ...
!> \version 1.0
! **************************************************************************************************
   SUBROUTINE dg_set(dg, dg_rho0, grid_index)
      TYPE(dg_type), POINTER                             :: dg
      TYPE(dg_rho0_type), OPTIONAL, POINTER              :: dg_rho0
      INTEGER, OPTIONAL                                  :: grid_index

      IF (PRESENT(dg_rho0)) THEN
         CALL dg_rho0_release(dg%dg_rho0)
         dg%dg_rho0 => dg_rho0
      END IF
      IF (PRESENT(grid_index)) dg%grid_index = grid_index
   END SUBROUTINE dg_set

END MODULE dg_types
