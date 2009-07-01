/*
===========================================================================
Copyright (C) 1999-2005 Id Software, Inc.
Copyright (C) 2000-2006 Tim Angus

This file is part of Tremfusion.

Tremfusion is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

Tremfusion is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Tremfusion; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
===========================================================================
*/
#include "q_shared.h"
#include "qcommon.h"

struct vm_s {
    intptr_t (*systemCall)(intptr_t *parms);
	intptr_t (QDECL *entryPoint)(int callNum, ...);
    char name[MAX_QPATH];
	void *dllHandle;
	int callLevel;
	vmInterpret_t interpret;

#if USE_LLVM
	// for llvm modules
	void *llvmModuleProvider;
#endif
};

extern vm_t *currentVM;

void *VM_LoadLLVM(vm_t *vm, intptr_t(*systemCalls)(intptr_t, ...));
void VM_UnloadLLVM(void *llvmModuleProvider);
