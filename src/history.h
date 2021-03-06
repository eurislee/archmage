/* Copyright (c) 2012, Bastien Dejean
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef ARCHMAGE_HISTORY_H
#define ARCHMAGE_HISTORY_H

#include "types.h"

history_t *make_history(monitor_t *m, desktop_t *d, node_t *n);
void history_add(monitor_t *m, desktop_t *d, node_t *n, bool focused);
void history_insert_after(history_t *a, history_t *b);
void history_insert_before(history_t *a, history_t *b);
void history_remove(desktop_t *d, node_t *n, bool deep);
void empty_history(void);
node_t *history_last_node(desktop_t *d, node_t *n);
desktop_t *history_last_desktop(monitor_t *m, desktop_t *d);
monitor_t *history_last_monitor(monitor_t *m);
bool history_find_newest_node(coordinates_t *ref, coordinates_t *dst, node_select_t *sel);
bool history_find_node(history_dir_t hdi, coordinates_t *ref, coordinates_t *dst, node_select_t *sel);
bool history_find_newest_desktop(coordinates_t *ref, coordinates_t *dst, desktop_select_t *sel);
bool history_find_desktop(history_dir_t hdi, coordinates_t *ref, coordinates_t *dst, desktop_select_t *sel);
bool history_find_newest_monitor(coordinates_t *ref, coordinates_t *dst, monitor_select_t *sel);
bool history_find_monitor(history_dir_t hdi, coordinates_t *ref, coordinates_t *dst, monitor_select_t *sel);
uint32_t history_rank(node_t *n);

#endif
