/*
Copyright 2024 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

spool &outputdir/opdb__sysprivs__&v_tag
prompt PKEY|CON_ID|GRANTEE|PRIVILEGE

SELECT
    :v_pkey AS pkey,
    &v_a_con_id AS con_id,
    grantee,
    privilege
FROM
    &v_tblprefix._sys_privs a
where grantee NOT IN
@&EXTRACTSDIR/exclude_schemas.sql
AND grantee NOT IN
@&EXTRACTSDIR/exclude_roles.sql
;


spool off
