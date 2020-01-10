PGDMP         0        
         x            PCMCEN    11.5    11.5 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    167024    PCMCEN    DATABASE     �   CREATE DATABASE "PCMCEN" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_India.1252' LC_CTYPE = 'English_India.1252';
    DROP DATABASE "PCMCEN";
             postgres    false            �           0    0    PCMCEN    DATABASE PROPERTIES     0   ALTER DATABASE "PCMCEN" CONNECTION LIMIT = 200;
                  postgres    false    3211                        3079    167025 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                  false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                       false    1                        3079    167034 	   tablefunc 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
    DROP EXTENSION tablefunc;
                  false            �           0    0    EXTENSION tablefunc    COMMENT     `   COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
                       false    3                       1255    167055 3   getparamvalue(character varying, character varying)    FUNCTION     $  CREATE FUNCTION public.getparamvalue(pk_val character varying, sk_val character varying, OUT currentval_a character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
  currentval_a:=(SELECT a.value from config a where a.pk = pk_val AND a.sk=sk_val);
  return;
 end;
$$;
 |   DROP FUNCTION public.getparamvalue(pk_val character varying, sk_val character varying, OUT currentval_a character varying);
       public       postgres    false                       1255    167056    getpath_location(integer)    FUNCTION     �  CREATE FUNCTION public.getpath_location(folder_id integer) RETURNS TABLE(folderid bigint, parentid bigint, fldrnm character varying)
    LANGUAGE plpgsql
    AS $$
    DECLARE
        --fol_id INTEGER=10;
    BEGIN
         
         RETURN QUERY
             WITH RECURSIVE DMS_Commontable(folderid, fldrnm, parentid) AS (
 SELECT fd.folderid,fd.fldrnm,fd.parentid from foldermst fd where fd.folderid =folder_id
  union all
select rs.folderid,rs.fldrnm,rs.ParentId from DMS_Commontable as rss
inner join FolderMst as rs on rs.folderid =rss.ParentId ) 
select r.FolderId,r.PARENTID,r.fldrnm from  DMS_Commontable r ORDER BY r.FolderId;
    END;
$$;
 :   DROP FUNCTION public.getpath_location(folder_id integer);
       public       postgres    false                       1255    167057 '   increment_currentval(character varying)    FUNCTION       CREATE FUNCTION public.increment_currentval(seqnm_a character varying, OUT currentval_a integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
   update AllSequence Set currentVal = currentVal+1 where seqNm=seqNm_a RETURNING currentVal into currentVal_a;
end;
$$;
 `   DROP FUNCTION public.increment_currentval(seqnm_a character varying, OUT currentval_a integer);
       public       postgres    false            �            1259    167058    allsequence    TABLE     n   CREATE TABLE public.allsequence (
    seqnm character varying(8) NOT NULL,
    currentval integer NOT NULL
);
    DROP TABLE public.allsequence;
       public         postgres    false            �            1259    167061    classtaggrp    TABLE     9  CREATE TABLE public.classtaggrp (
    classid bigint NOT NULL,
    taggrpid bigint NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT classtaggrp_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.classtaggrp;
       public         postgres    false            �            1259    183147 
   compartmst    TABLE     �   CREATE TABLE public.compartmst (
    compid integer NOT NULL,
    rackid integer NOT NULL,
    shelfid integer NOT NULL,
    compno character varying(200) NOT NULL
);
    DROP TABLE public.compartmst;
       public         postgres    false            �            1259    183145    compartmst_compid_seq    SEQUENCE     �   CREATE SEQUENCE public.compartmst_compid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.compartmst_compid_seq;
       public       postgres    false    245            �           0    0    compartmst_compid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.compartmst_compid_seq OWNED BY public.compartmst.compid;
            public       postgres    false    244            �            1259    167066    config    TABLE     �   CREATE TABLE public.config (
    pk character(3) NOT NULL,
    sk character(4) NOT NULL,
    ds character varying(50) NOT NULL,
    value character varying(50)
);
    DROP TABLE public.config;
       public         postgres    false            �            1259    167069    deptmst    TABLE     A  CREATE TABLE public.deptmst (
    deptid integer NOT NULL,
    deptnm character varying(100) NOT NULL,
    shrtnm character varying(4),
    creationdt timestamp without time zone,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT deptmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.deptmst;
       public         postgres    false            �            1259    167074    deptmst_deptid_seq    SEQUENCE     �   CREATE SEQUENCE public.deptmst_deptid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.deptmst_deptid_seq;
       public       postgres    false    204            �           0    0    deptmst_deptid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.deptmst_deptid_seq OWNED BY public.deptmst.deptid;
            public       postgres    false    205            �            1259    167076    desigmst    TABLE     C  CREATE TABLE public.desigmst (
    desgid integer NOT NULL,
    desgnm character varying(100) NOT NULL,
    shrtnm character varying(4),
    creationdt timestamp without time zone,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT desigmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.desigmst;
       public         postgres    false            �            1259    167081    desigmst_desgid_seq    SEQUENCE     �   CREATE SEQUENCE public.desigmst_desgid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.desigmst_desgid_seq;
       public       postgres    false    206            �           0    0    desigmst_desgid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.desigmst_desgid_seq OWNED BY public.desigmst.desgid;
            public       postgres    false    207            �            1259    167083    filemst    TABLE     K  CREATE TABLE public.filemst (
    fileid bigint NOT NULL,
    seqno integer NOT NULL,
    folderid bigint NOT NULL,
    rootid bigint NOT NULL,
    filenm character varying(200) NOT NULL,
    filecontents bytea NOT NULL,
    fileextn character(80) NOT NULL,
    atribt character(1) DEFAULT 'A'::bpchar NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    modifiedby bigint,
    modificationdt timestamp without time zone,
    pagecnt integer,
    filepath text,
    filelocation text NOT NULL,
    tagstatus character(1) DEFAULT 'N'::bpchar NOT NULL,
    tagdtentry timestamp without time zone,
    vertype character(2) DEFAULT 'BT'::bpchar NOT NULL,
    verno integer DEFAULT 1 NOT NULL,
    verid integer DEFAULT 0 NOT NULL,
    a0size integer DEFAULT 0 NOT NULL,
    a1size integer DEFAULT 0 NOT NULL,
    a2size integer DEFAULT 0 NOT NULL,
    a3size integer DEFAULT 0 NOT NULL,
    a4size integer DEFAULT 0 NOT NULL,
    subdeptid bigint DEFAULT 0 NOT NULL,
    CONSTRAINT filemst_atribt_check CHECK ((atribt = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'R'::bpchar, 'H'::bpchar, 'O'::bpchar]))),
    CONSTRAINT filemst_tagstatus_check CHECK ((tagstatus = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT filemst_vertype_check CHECK ((vertype = ANY (ARRAY['BT'::bpchar, 'MN'::bpchar, 'MJ'::bpchar])))
);
    DROP TABLE public.filemst;
       public         postgres    false            �            1259    167103    filetagsdata    TABLE     �  CREATE TABLE public.filetagsdata (
    ftagid bigint NOT NULL,
    fileid bigint NOT NULL,
    seqno integer NOT NULL,
    taggrpid bigint NOT NULL,
    tagid integer NOT NULL,
    tagdata character varying(200) NOT NULL,
    listid integer NOT NULL,
    listno integer NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    classid bigint DEFAULT 0 NOT NULL
);
     DROP TABLE public.filetagsdata;
       public         postgres    false            �            1259    167107    filetagsdata_ftagid_seq    SEQUENCE     �   CREATE SEQUENCE public.filetagsdata_ftagid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.filetagsdata_ftagid_seq;
       public       postgres    false    209            �           0    0    filetagsdata_ftagid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.filetagsdata_ftagid_seq OWNED BY public.filetagsdata.ftagid;
            public       postgres    false    210            �            1259    167109 	   foldermst    TABLE     l  CREATE TABLE public.foldermst (
    folderid bigint NOT NULL,
    parentid bigint DEFAULT 0 NOT NULL,
    rootid bigint DEFAULT 0 NOT NULL,
    deptid integer NOT NULL,
    fldrnm character varying(200) NOT NULL,
    isinnerfolders character(1) DEFAULT 'Y'::bpchar NOT NULL,
    foldercnt integer DEFAULT 0,
    filecnt integer DEFAULT 0,
    atribt character(1) DEFAULT 'A'::bpchar NOT NULL,
    readonlyothdept character(1) DEFAULT 'N'::bpchar,
    readonlypublic character(1) DEFAULT 'N'::bpchar,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone,
    folderpath text,
    location text,
    rmk text,
    subdeptid bigint DEFAULT 0 NOT NULL,
    CONSTRAINT foldermst_atribt_check CHECK ((atribt = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'R'::bpchar, 'H'::bpchar]))),
    CONSTRAINT foldermst_isinnerfolders_check CHECK ((isinnerfolders = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT foldermst_readonlyothdept_check CHECK ((readonlyothdept = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT foldermst_readonlypublic_check CHECK ((readonlypublic = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);
    DROP TABLE public.foldermst;
       public         postgres    false            �            1259    167128    foldermst_folderid_seq    SEQUENCE        CREATE SEQUENCE public.foldermst_folderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.foldermst_folderid_seq;
       public       postgres    false    211            �           0    0    foldermst_folderid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.foldermst_folderid_seq OWNED BY public.foldermst.folderid;
            public       postgres    false    212            �            1259    167130    groupmst    TABLE     L  CREATE TABLE public.groupmst (
    groupid integer NOT NULL,
    grpnm character varying(30) NOT NULL,
    shrtnm character varying(10) NOT NULL,
    creationdt timestamp without time zone,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT groupmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.groupmst;
       public         postgres    false            �            1259    167135    groupmst_groupid_seq    SEQUENCE     �   CREATE SEQUENCE public.groupmst_groupid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.groupmst_groupid_seq;
       public       postgres    false    213            �           0    0    groupmst_groupid_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.groupmst_groupid_seq OWNED BY public.groupmst.groupid;
            public       postgres    false    214            �            1259    167137    hintquestionmst    TABLE     v   CREATE TABLE public.hintquestionmst (
    hintid integer NOT NULL,
    hintquestion character varying(50) NOT NULL
);
 #   DROP TABLE public.hintquestionmst;
       public         postgres    false            �            1259    167140    hintquestionmst_hintid_seq    SEQUENCE     �   CREATE SEQUENCE public.hintquestionmst_hintid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.hintquestionmst_hintid_seq;
       public       postgres    false    215            �           0    0    hintquestionmst_hintid_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.hintquestionmst_hintid_seq OWNED BY public.hintquestionmst.hintid;
            public       postgres    false    216            �            1259    167142 
   hisfilemst    TABLE     �  CREATE TABLE public.hisfilemst (
    histid bigint NOT NULL,
    fileid integer NOT NULL,
    seqno integer NOT NULL,
    filenm character varying(200) NOT NULL,
    atribt character(1) DEFAULT 'A'::bpchar NOT NULL,
    remark character varying(200),
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    CONSTRAINT hisfilemst_atribt_check CHECK ((atribt = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'R'::bpchar, 'H'::bpchar, 'O'::bpchar])))
);
    DROP TABLE public.hisfilemst;
       public         postgres    false            �            1259    167147    hisfilemst_histid_seq    SEQUENCE     ~   CREATE SEQUENCE public.hisfilemst_histid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.hisfilemst_histid_seq;
       public       postgres    false    217            �           0    0    hisfilemst_histid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.hisfilemst_histid_seq OWNED BY public.hisfilemst.histid;
            public       postgres    false    218            �            1259    167149    hisfoldermst    TABLE     �  CREATE TABLE public.hisfoldermst (
    hisid bigint NOT NULL,
    folderid bigint NOT NULL,
    foldernm character varying(200) NOT NULL,
    isinnerfolder character(1) NOT NULL,
    atribt character(1) DEFAULT 'A'::bpchar,
    readonlyothdept character(1),
    readonlypublic character(1),
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    CONSTRAINT hisfoldermst_atribt_check CHECK ((atribt = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'R'::bpchar, 'H'::bpchar])))
);
     DROP TABLE public.hisfoldermst;
       public         postgres    false            �            1259    167154    hisfoldermst_hisid_seq    SEQUENCE        CREATE SEQUENCE public.hisfoldermst_hisid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.hisfoldermst_hisid_seq;
       public       postgres    false    219            �           0    0    hisfoldermst_hisid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.hisfoldermst_hisid_seq OWNED BY public.hisfoldermst.hisid;
            public       postgres    false    220            �            1259    167156    listdata    TABLE     j  CREATE TABLE public.listdata (
    listid integer NOT NULL,
    listno integer NOT NULL,
    listvalue character varying(100) NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT listdata_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.listdata;
       public         postgres    false            �            1259    167161    listmst    TABLE     J  CREATE TABLE public.listmst (
    listid integer NOT NULL,
    listname character varying(100) NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT listmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.listmst;
       public         postgres    false            �            1259    167166    menu    TABLE     E  CREATE TABLE public.menu (
    mid integer NOT NULL,
    pid integer NOT NULL,
    mstyle character(1) DEFAULT 'H'::bpchar,
    menunm character varying(40) NOT NULL,
    pagenm character varying(50) NOT NULL,
    status character(1) DEFAULT 'A'::bpchar,
    lang character(2) DEFAULT 'EN'::bpchar NOT NULL,
    CONSTRAINT menu_lang_check CHECK ((lang = ANY (ARRAY['EN'::bpchar, 'MR'::bpchar]))),
    CONSTRAINT menu_mstyle_check CHECK ((mstyle = ANY (ARRAY['H'::bpchar, 'V'::bpchar]))),
    CONSTRAINT menu_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.menu;
       public         postgres    false            �            1259    167175    menu_mid_seq    SEQUENCE     �   CREATE SEQUENCE public.menu_mid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.menu_mid_seq;
       public       postgres    false    223            �           0    0    menu_mid_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.menu_mid_seq OWNED BY public.menu.mid;
            public       postgres    false    224            �            1259    167177 
   messagemst    TABLE       CREATE TABLE public.messagemst (
    messageid integer NOT NULL,
    messagefrom bigint NOT NULL,
    messageto text NOT NULL,
    fileid text NOT NULL,
    subject character varying(200) NOT NULL,
    comment text,
    creationdt timestamp without time zone NOT NULL
);
    DROP TABLE public.messagemst;
       public         postgres    false            �            1259    167183    messagemst_messageid_seq    SEQUENCE     �   CREATE SEQUENCE public.messagemst_messageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.messagemst_messageid_seq;
       public       postgres    false    225            �           0    0    messagemst_messageid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.messagemst_messageid_seq OWNED BY public.messagemst.messageid;
            public       postgres    false    226            �            1259    183124    rackmst    TABLE     i   CREATE TABLE public.rackmst (
    rackid integer NOT NULL,
    rackno character varying(200) NOT NULL
);
    DROP TABLE public.rackmst;
       public         postgres    false            �            1259    183122    rackmst_rackid_seq    SEQUENCE     �   CREATE SEQUENCE public.rackmst_rackid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.rackmst_rackid_seq;
       public       postgres    false    241            �           0    0    rackmst_rackid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.rackmst_rackid_seq OWNED BY public.rackmst.rackid;
            public       postgres    false    240            �            1259    167185    searchcondition    TABLE     �   CREATE TABLE public.searchcondition (
    srno integer NOT NULL,
    tagtypeid integer NOT NULL,
    frontdata character varying(200) NOT NULL,
    backdata character varying(50) NOT NULL
);
 #   DROP TABLE public.searchcondition;
       public         postgres    false            �            1259    167188    searchcondition_srno_seq    SEQUENCE     �   CREATE SEQUENCE public.searchcondition_srno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.searchcondition_srno_seq;
       public       postgres    false    227            �           0    0    searchcondition_srno_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.searchcondition_srno_seq OWNED BY public.searchcondition.srno;
            public       postgres    false    228            �            1259    183134    shelfmst    TABLE     �   CREATE TABLE public.shelfmst (
    shelfid integer NOT NULL,
    rackid integer NOT NULL,
    shelfno character varying(200) NOT NULL
);
    DROP TABLE public.shelfmst;
       public         postgres    false            �            1259    183132    shelfmst_shelfid_seq    SEQUENCE     �   CREATE SEQUENCE public.shelfmst_shelfid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shelfmst_shelfid_seq;
       public       postgres    false    243            �           0    0    shelfmst_shelfid_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shelfmst_shelfid_seq OWNED BY public.shelfmst.shelfid;
            public       postgres    false    242            �            1259    167190 
   subdeptmst    TABLE     j  CREATE TABLE public.subdeptmst (
    subdeptid integer NOT NULL,
    subdeptnm character varying(100) NOT NULL,
    shrtnm character varying(4),
    creationdt timestamp without time zone,
    deptid integer NOT NULL,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT subdeptmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.subdeptmst;
       public         postgres    false            �            1259    167195    subdeptmst_subdeptid_seq    SEQUENCE     �   CREATE SEQUENCE public.subdeptmst_subdeptid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.subdeptmst_subdeptid_seq;
       public       postgres    false    229            �           0    0    subdeptmst_subdeptid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.subdeptmst_subdeptid_seq OWNED BY public.subdeptmst.subdeptid;
            public       postgres    false    230            �            1259    167197 	   taggrpmst    TABLE     F  CREATE TABLE public.taggrpmst (
    taggrpid bigint NOT NULL,
    taggrpnm character varying(100) NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone,
    status character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT taggrpmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.taggrpmst;
       public         postgres    false            �            1259    167202    tagmst    TABLE     r  CREATE TABLE public.tagmst (
    taggrpid bigint NOT NULL,
    tagid integer NOT NULL,
    tagnm character varying(100) NOT NULL,
    tagtypeid integer NOT NULL,
    width integer NOT NULL,
    ismandatory character(1) NOT NULL,
    listid integer NOT NULL,
    dispseqno integer NOT NULL,
    createdby bigint NOT NULL,
    creationdt timestamp without time zone NOT NULL,
    status character(1) DEFAULT 'A'::bpchar NOT NULL,
    CONSTRAINT tagmst_ismandatory_check CHECK ((ismandatory = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT tagmst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.tagmst;
       public         postgres    false            �            1259    167208    tagmst_taggrpid_seq    SEQUENCE     |   CREATE SEQUENCE public.tagmst_taggrpid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tagmst_taggrpid_seq;
       public       postgres    false    232            �           0    0    tagmst_taggrpid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tagmst_taggrpid_seq OWNED BY public.tagmst.taggrpid;
            public       postgres    false    233            �            1259    167210 
   tagtypemst    TABLE     -  CREATE TABLE public.tagtypemst (
    tagtypeid integer NOT NULL,
    tagtypedesc character varying(100) NOT NULL,
    tagtypeshrtdesc character(3),
    status character(1) DEFAULT 'A'::bpchar NOT NULL,
    CONSTRAINT tagtypemst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.tagtypemst;
       public         postgres    false            �            1259    167215    tagtypemst_tagtypeid_seq    SEQUENCE     �   CREATE SEQUENCE public.tagtypemst_tagtypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.tagtypemst_tagtypeid_seq;
       public       postgres    false    234            �           0    0    tagtypemst_tagtypeid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.tagtypemst_tagtypeid_seq OWNED BY public.tagtypemst.tagtypeid;
            public       postgres    false    235            �            1259    167451    tempusermst    TABLE     �   CREATE TABLE public.tempusermst (
    userno integer NOT NULL,
    usernm character varying(200),
    departmentname character varying(200),
    designation character varying(200),
    mobno numeric(12,0),
    email character varying(200)
);
    DROP TABLE public.tempusermst;
       public         postgres    false            �            1259    167217    uacc    TABLE     �  CREATE TABLE public.uacc (
    userid bigint NOT NULL,
    mid integer NOT NULL,
    aadd character(1) DEFAULT 'A'::bpchar,
    aupdate character(1) DEFAULT 'A'::bpchar,
    adel character(1) DEFAULT 'A'::bpchar,
    aview character(1) DEFAULT 'A'::bpchar,
    apass character(1) DEFAULT 'A'::bpchar,
    CONSTRAINT uacc_aadd_check CHECK ((aadd = ANY (ARRAY['A'::bpchar, 'D'::bpchar]))),
    CONSTRAINT uacc_adel_check CHECK ((adel = ANY (ARRAY['A'::bpchar, 'D'::bpchar]))),
    CONSTRAINT uacc_apass_check CHECK ((apass = ANY (ARRAY['A'::bpchar, 'D'::bpchar]))),
    CONSTRAINT uacc_aupdate_check CHECK ((aupdate = ANY (ARRAY['A'::bpchar, 'D'::bpchar]))),
    CONSTRAINT uacc_aview_check CHECK ((aview = ANY (ARRAY['A'::bpchar, 'D'::bpchar])))
);
    DROP TABLE public.uacc;
       public         postgres    false            �            1259    167230    usermst    TABLE     2  CREATE TABLE public.usermst (
    userid bigint NOT NULL,
    emailid character varying(100) NOT NULL,
    username character varying(200) NOT NULL,
    address character varying(300),
    mobno numeric(12,0) NOT NULL,
    deptid integer NOT NULL,
    desgid integer NOT NULL,
    userlevel integer NOT NULL,
    upw1 character varying(15) NOT NULL,
    upw2 character varying(15),
    upw3 character varying(15),
    createdby character varying(200) NOT NULL,
    hintid integer,
    hintans character varying(50),
    otp character varying(10),
    groupid integer,
    creationdt timestamp without time zone,
    status character(1) DEFAULT 'A'::bpchar,
    profileimage bytea,
    userno bigint NOT NULL,
    CONSTRAINT usermst_status_check CHECK ((status = ANY (ARRAY['A'::bpchar, 'T'::bpchar, 'S'::bpchar])))
);
    DROP TABLE public.usermst;
       public         postgres    false            �            1259    167238    usermst_userid_seq    SEQUENCE     {   CREATE SEQUENCE public.usermst_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.usermst_userid_seq;
       public       postgres    false    237            �           0    0    usermst_userid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.usermst_userid_seq OWNED BY public.usermst.userid;
            public       postgres    false    238                       2604    183150    compartmst compid    DEFAULT     v   ALTER TABLE ONLY public.compartmst ALTER COLUMN compid SET DEFAULT nextval('public.compartmst_compid_seq'::regclass);
 @   ALTER TABLE public.compartmst ALTER COLUMN compid DROP DEFAULT;
       public       postgres    false    245    244    245            +           2604    167240    deptmst deptid    DEFAULT     p   ALTER TABLE ONLY public.deptmst ALTER COLUMN deptid SET DEFAULT nextval('public.deptmst_deptid_seq'::regclass);
 =   ALTER TABLE public.deptmst ALTER COLUMN deptid DROP DEFAULT;
       public       postgres    false    205    204            .           2604    167241    desigmst desgid    DEFAULT     r   ALTER TABLE ONLY public.desigmst ALTER COLUMN desgid SET DEFAULT nextval('public.desigmst_desgid_seq'::regclass);
 >   ALTER TABLE public.desigmst ALTER COLUMN desgid DROP DEFAULT;
       public       postgres    false    207    206            ?           2604    167242    filetagsdata ftagid    DEFAULT     z   ALTER TABLE ONLY public.filetagsdata ALTER COLUMN ftagid SET DEFAULT nextval('public.filetagsdata_ftagid_seq'::regclass);
 B   ALTER TABLE public.filetagsdata ALTER COLUMN ftagid DROP DEFAULT;
       public       postgres    false    210    209            I           2604    167243    foldermst folderid    DEFAULT     x   ALTER TABLE ONLY public.foldermst ALTER COLUMN folderid SET DEFAULT nextval('public.foldermst_folderid_seq'::regclass);
 A   ALTER TABLE public.foldermst ALTER COLUMN folderid DROP DEFAULT;
       public       postgres    false    212    211            O           2604    167244    groupmst groupid    DEFAULT     t   ALTER TABLE ONLY public.groupmst ALTER COLUMN groupid SET DEFAULT nextval('public.groupmst_groupid_seq'::regclass);
 ?   ALTER TABLE public.groupmst ALTER COLUMN groupid DROP DEFAULT;
       public       postgres    false    214    213            Q           2604    167245    hintquestionmst hintid    DEFAULT     �   ALTER TABLE ONLY public.hintquestionmst ALTER COLUMN hintid SET DEFAULT nextval('public.hintquestionmst_hintid_seq'::regclass);
 E   ALTER TABLE public.hintquestionmst ALTER COLUMN hintid DROP DEFAULT;
       public       postgres    false    216    215            S           2604    167246    hisfilemst histid    DEFAULT     v   ALTER TABLE ONLY public.hisfilemst ALTER COLUMN histid SET DEFAULT nextval('public.hisfilemst_histid_seq'::regclass);
 @   ALTER TABLE public.hisfilemst ALTER COLUMN histid DROP DEFAULT;
       public       postgres    false    218    217            V           2604    167247    hisfoldermst hisid    DEFAULT     x   ALTER TABLE ONLY public.hisfoldermst ALTER COLUMN hisid SET DEFAULT nextval('public.hisfoldermst_hisid_seq'::regclass);
 A   ALTER TABLE public.hisfoldermst ALTER COLUMN hisid DROP DEFAULT;
       public       postgres    false    220    219            _           2604    167248    menu mid    DEFAULT     d   ALTER TABLE ONLY public.menu ALTER COLUMN mid SET DEFAULT nextval('public.menu_mid_seq'::regclass);
 7   ALTER TABLE public.menu ALTER COLUMN mid DROP DEFAULT;
       public       postgres    false    224    223            }           2604    183127    rackmst rackid    DEFAULT     p   ALTER TABLE ONLY public.rackmst ALTER COLUMN rackid SET DEFAULT nextval('public.rackmst_rackid_seq'::regclass);
 =   ALTER TABLE public.rackmst ALTER COLUMN rackid DROP DEFAULT;
       public       postgres    false    240    241    241            c           2604    167249    searchcondition srno    DEFAULT     |   ALTER TABLE ONLY public.searchcondition ALTER COLUMN srno SET DEFAULT nextval('public.searchcondition_srno_seq'::regclass);
 C   ALTER TABLE public.searchcondition ALTER COLUMN srno DROP DEFAULT;
       public       postgres    false    228    227            ~           2604    183137    shelfmst shelfid    DEFAULT     t   ALTER TABLE ONLY public.shelfmst ALTER COLUMN shelfid SET DEFAULT nextval('public.shelfmst_shelfid_seq'::regclass);
 ?   ALTER TABLE public.shelfmst ALTER COLUMN shelfid DROP DEFAULT;
       public       postgres    false    243    242    243            e           2604    167250    subdeptmst subdeptid    DEFAULT     |   ALTER TABLE ONLY public.subdeptmst ALTER COLUMN subdeptid SET DEFAULT nextval('public.subdeptmst_subdeptid_seq'::regclass);
 C   ALTER TABLE public.subdeptmst ALTER COLUMN subdeptid DROP DEFAULT;
       public       postgres    false    230    229            j           2604    167251    tagmst taggrpid    DEFAULT     r   ALTER TABLE ONLY public.tagmst ALTER COLUMN taggrpid SET DEFAULT nextval('public.tagmst_taggrpid_seq'::regclass);
 >   ALTER TABLE public.tagmst ALTER COLUMN taggrpid DROP DEFAULT;
       public       postgres    false    233    232            n           2604    167252    tagtypemst tagtypeid    DEFAULT     |   ALTER TABLE ONLY public.tagtypemst ALTER COLUMN tagtypeid SET DEFAULT nextval('public.tagtypemst_tagtypeid_seq'::regclass);
 C   ALTER TABLE public.tagtypemst ALTER COLUMN tagtypeid DROP DEFAULT;
       public       postgres    false    235    234            {           2604    167253    usermst userid    DEFAULT     p   ALTER TABLE ONLY public.usermst ALTER COLUMN userid SET DEFAULT nextval('public.usermst_userid_seq'::regclass);
 =   ALTER TABLE public.usermst ALTER COLUMN userid DROP DEFAULT;
       public       postgres    false    238    237            Y          0    167058    allsequence 
   TABLE DATA               8   COPY public.allsequence (seqnm, currentval) FROM stdin;
    public       postgres    false    201   [	      Z          0    167061    classtaggrp 
   TABLE DATA               W   COPY public.classtaggrp (classid, taggrpid, createdby, creationdt, status) FROM stdin;
    public       postgres    false    202   �	      �          0    183147 
   compartmst 
   TABLE DATA               E   COPY public.compartmst (compid, rackid, shelfid, compno) FROM stdin;
    public       postgres    false    245   �	      [          0    167066    config 
   TABLE DATA               3   COPY public.config (pk, sk, ds, value) FROM stdin;
    public       postgres    false    203   �	      \          0    167069    deptmst 
   TABLE DATA               M   COPY public.deptmst (deptid, deptnm, shrtnm, creationdt, status) FROM stdin;
    public       postgres    false    204   ^
      ^          0    167076    desigmst 
   TABLE DATA               N   COPY public.desigmst (desgid, desgnm, shrtnm, creationdt, status) FROM stdin;
    public       postgres    false    206   8      `          0    167083    filemst 
   TABLE DATA                 COPY public.filemst (fileid, seqno, folderid, rootid, filenm, filecontents, fileextn, atribt, createdby, creationdt, modifiedby, modificationdt, pagecnt, filepath, filelocation, tagstatus, tagdtentry, vertype, verno, verid, a0size, a1size, a2size, a3size, a4size, subdeptid) FROM stdin;
    public       postgres    false    208   j      a          0    167103    filetagsdata 
   TABLE DATA               �   COPY public.filetagsdata (ftagid, fileid, seqno, taggrpid, tagid, tagdata, listid, listno, createdby, creationdt, classid) FROM stdin;
    public       postgres    false    209   �      c          0    167109 	   foldermst 
   TABLE DATA               �   COPY public.foldermst (folderid, parentid, rootid, deptid, fldrnm, isinnerfolders, foldercnt, filecnt, atribt, readonlyothdept, readonlypublic, createdby, creationdt, folderpath, location, rmk, subdeptid) FROM stdin;
    public       postgres    false    211   �      e          0    167130    groupmst 
   TABLE DATA               N   COPY public.groupmst (groupid, grpnm, shrtnm, creationdt, status) FROM stdin;
    public       postgres    false    213   �      g          0    167137    hintquestionmst 
   TABLE DATA               ?   COPY public.hintquestionmst (hintid, hintquestion) FROM stdin;
    public       postgres    false    215   �      i          0    167142 
   hisfilemst 
   TABLE DATA               j   COPY public.hisfilemst (histid, fileid, seqno, filenm, atribt, remark, createdby, creationdt) FROM stdin;
    public       postgres    false    217   �      k          0    167149    hisfoldermst 
   TABLE DATA               �   COPY public.hisfoldermst (hisid, folderid, foldernm, isinnerfolder, atribt, readonlyothdept, readonlypublic, createdby, creationdt) FROM stdin;
    public       postgres    false    219   �      m          0    167156    listdata 
   TABLE DATA               \   COPY public.listdata (listid, listno, listvalue, createdby, creationdt, status) FROM stdin;
    public       postgres    false    221   	      n          0    167161    listmst 
   TABLE DATA               R   COPY public.listmst (listid, listname, createdby, creationdt, status) FROM stdin;
    public       postgres    false    222   K      o          0    167166    menu 
   TABLE DATA               N   COPY public.menu (mid, pid, mstyle, menunm, pagenm, status, lang) FROM stdin;
    public       postgres    false    223   �      q          0    167177 
   messagemst 
   TABLE DATA               m   COPY public.messagemst (messageid, messagefrom, messageto, fileid, subject, comment, creationdt) FROM stdin;
    public       postgres    false    225   �      �          0    183124    rackmst 
   TABLE DATA               1   COPY public.rackmst (rackid, rackno) FROM stdin;
    public       postgres    false    241   �      s          0    167185    searchcondition 
   TABLE DATA               O   COPY public.searchcondition (srno, tagtypeid, frontdata, backdata) FROM stdin;
    public       postgres    false    227   �      �          0    183134    shelfmst 
   TABLE DATA               <   COPY public.shelfmst (shelfid, rackid, shelfno) FROM stdin;
    public       postgres    false    243   �      u          0    167190 
   subdeptmst 
   TABLE DATA               ^   COPY public.subdeptmst (subdeptid, subdeptnm, shrtnm, creationdt, deptid, status) FROM stdin;
    public       postgres    false    229   �      w          0    167197 	   taggrpmst 
   TABLE DATA               V   COPY public.taggrpmst (taggrpid, taggrpnm, createdby, creationdt, status) FROM stdin;
    public       postgres    false    231   �!      x          0    167202    tagmst 
   TABLE DATA               �   COPY public.tagmst (taggrpid, tagid, tagnm, tagtypeid, width, ismandatory, listid, dispseqno, createdby, creationdt, status) FROM stdin;
    public       postgres    false    232   �!      z          0    167210 
   tagtypemst 
   TABLE DATA               U   COPY public.tagtypemst (tagtypeid, tagtypedesc, tagtypeshrtdesc, status) FROM stdin;
    public       postgres    false    234   �!                0    167451    tempusermst 
   TABLE DATA               `   COPY public.tempusermst (userno, usernm, departmentname, designation, mobno, email) FROM stdin;
    public       postgres    false    239   \"      |          0    167217    uacc 
   TABLE DATA               N   COPY public.uacc (userid, mid, aadd, aupdate, adel, aview, apass) FROM stdin;
    public       postgres    false    236   �B      }          0    167230    usermst 
   TABLE DATA               �   COPY public.usermst (userid, emailid, username, address, mobno, deptid, desgid, userlevel, upw1, upw2, upw3, createdby, hintid, hintans, otp, groupid, creationdt, status, profileimage, userno) FROM stdin;
    public       postgres    false    237   �C      �           0    0    compartmst_compid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.compartmst_compid_seq', 1, false);
            public       postgres    false    244            �           0    0    deptmst_deptid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.deptmst_deptid_seq', 45, true);
            public       postgres    false    205            �           0    0    desigmst_desgid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.desigmst_desgid_seq', 53, true);
            public       postgres    false    207            �           0    0    filetagsdata_ftagid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.filetagsdata_ftagid_seq', 1, false);
            public       postgres    false    210            �           0    0    foldermst_folderid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.foldermst_folderid_seq', 1, false);
            public       postgres    false    212            �           0    0    groupmst_groupid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.groupmst_groupid_seq', 63, true);
            public       postgres    false    214            �           0    0    hintquestionmst_hintid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.hintquestionmst_hintid_seq', 2, true);
            public       postgres    false    216            �           0    0    hisfilemst_histid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.hisfilemst_histid_seq', 1, false);
            public       postgres    false    218            �           0    0    hisfoldermst_hisid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.hisfoldermst_hisid_seq', 1, false);
            public       postgres    false    220            �           0    0    menu_mid_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.menu_mid_seq', 60, true);
            public       postgres    false    224            �           0    0    messagemst_messageid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.messagemst_messageid_seq', 1, false);
            public       postgres    false    226            �           0    0    rackmst_rackid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.rackmst_rackid_seq', 5, true);
            public       postgres    false    240            �           0    0    searchcondition_srno_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.searchcondition_srno_seq', 27, true);
            public       postgres    false    228            �           0    0    shelfmst_shelfid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shelfmst_shelfid_seq', 3, true);
            public       postgres    false    242            �           0    0    subdeptmst_subdeptid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.subdeptmst_subdeptid_seq', 86, true);
            public       postgres    false    230            �           0    0    tagmst_taggrpid_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tagmst_taggrpid_seq', 1, false);
            public       postgres    false    233            �           0    0    tagtypemst_tagtypeid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.tagtypemst_tagtypeid_seq', 7, true);
            public       postgres    false    235            �           0    0    usermst_userid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.usermst_userid_seq', 2, true);
            public       postgres    false    238            �           2606    167255    allsequence allsequence_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.allsequence
    ADD CONSTRAINT allsequence_pkey PRIMARY KEY (seqnm);
 F   ALTER TABLE ONLY public.allsequence DROP CONSTRAINT allsequence_pkey;
       public         postgres    false    201            �           2606    167257    classtaggrp classtaggrp_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.classtaggrp
    ADD CONSTRAINT classtaggrp_pkey PRIMARY KEY (classid, taggrpid);
 F   ALTER TABLE ONLY public.classtaggrp DROP CONSTRAINT classtaggrp_pkey;
       public         postgres    false    202    202            �           2606    183152    compartmst compartmst_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.compartmst
    ADD CONSTRAINT compartmst_pkey PRIMARY KEY (compid);
 D   ALTER TABLE ONLY public.compartmst DROP CONSTRAINT compartmst_pkey;
       public         postgres    false    245            �           2606    167259    config config_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (pk, sk);
 <   ALTER TABLE ONLY public.config DROP CONSTRAINT config_pkey;
       public         postgres    false    203    203            �           2606    167261    deptmst deptmst_deptnm_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.deptmst
    ADD CONSTRAINT deptmst_deptnm_key UNIQUE (deptnm);
 D   ALTER TABLE ONLY public.deptmst DROP CONSTRAINT deptmst_deptnm_key;
       public         postgres    false    204            �           2606    167263    deptmst deptmst_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.deptmst
    ADD CONSTRAINT deptmst_pkey PRIMARY KEY (deptid);
 >   ALTER TABLE ONLY public.deptmst DROP CONSTRAINT deptmst_pkey;
       public         postgres    false    204            �           2606    167265    desigmst desigmst_desgnm_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.desigmst
    ADD CONSTRAINT desigmst_desgnm_key UNIQUE (desgnm);
 F   ALTER TABLE ONLY public.desigmst DROP CONSTRAINT desigmst_desgnm_key;
       public         postgres    false    206            �           2606    167267    desigmst desigmst_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.desigmst
    ADD CONSTRAINT desigmst_pkey PRIMARY KEY (desgid);
 @   ALTER TABLE ONLY public.desigmst DROP CONSTRAINT desigmst_pkey;
       public         postgres    false    206            �           2606    167269    filemst filemst_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.filemst
    ADD CONSTRAINT filemst_pkey PRIMARY KEY (fileid, seqno);
 >   ALTER TABLE ONLY public.filemst DROP CONSTRAINT filemst_pkey;
       public         postgres    false    208    208            �           2606    167271    filetagsdata filetagsdata_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.filetagsdata
    ADD CONSTRAINT filetagsdata_pkey PRIMARY KEY (ftagid);
 H   ALTER TABLE ONLY public.filetagsdata DROP CONSTRAINT filetagsdata_pkey;
       public         postgres    false    209            �           2606    167273    foldermst foldermst_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.foldermst
    ADD CONSTRAINT foldermst_pkey PRIMARY KEY (folderid);
 B   ALTER TABLE ONLY public.foldermst DROP CONSTRAINT foldermst_pkey;
       public         postgres    false    211            �           2606    167275    groupmst groupmst_grpnm_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.groupmst
    ADD CONSTRAINT groupmst_grpnm_key UNIQUE (grpnm);
 E   ALTER TABLE ONLY public.groupmst DROP CONSTRAINT groupmst_grpnm_key;
       public         postgres    false    213            �           2606    167277    groupmst groupmst_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.groupmst
    ADD CONSTRAINT groupmst_pkey PRIMARY KEY (groupid);
 @   ALTER TABLE ONLY public.groupmst DROP CONSTRAINT groupmst_pkey;
       public         postgres    false    213            �           2606    167279 $   hintquestionmst hintquestionmst_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.hintquestionmst
    ADD CONSTRAINT hintquestionmst_pkey PRIMARY KEY (hintid);
 N   ALTER TABLE ONLY public.hintquestionmst DROP CONSTRAINT hintquestionmst_pkey;
       public         postgres    false    215            �           2606    167281    hisfilemst hisfilemst_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.hisfilemst
    ADD CONSTRAINT hisfilemst_pkey PRIMARY KEY (histid);
 D   ALTER TABLE ONLY public.hisfilemst DROP CONSTRAINT hisfilemst_pkey;
       public         postgres    false    217            �           2606    167283    hisfoldermst hisfoldermst_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.hisfoldermst
    ADD CONSTRAINT hisfoldermst_pkey PRIMARY KEY (hisid);
 H   ALTER TABLE ONLY public.hisfoldermst DROP CONSTRAINT hisfoldermst_pkey;
       public         postgres    false    219            �           2606    167285    listdata listdata_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.listdata
    ADD CONSTRAINT listdata_pkey PRIMARY KEY (listid, listno);
 @   ALTER TABLE ONLY public.listdata DROP CONSTRAINT listdata_pkey;
       public         postgres    false    221    221            �           2606    167287    listmst listmst_listname_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.listmst
    ADD CONSTRAINT listmst_listname_key UNIQUE (listname);
 F   ALTER TABLE ONLY public.listmst DROP CONSTRAINT listmst_listname_key;
       public         postgres    false    222            �           2606    167289    listmst listmst_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.listmst
    ADD CONSTRAINT listmst_pkey PRIMARY KEY (listid);
 >   ALTER TABLE ONLY public.listmst DROP CONSTRAINT listmst_pkey;
       public         postgres    false    222            �           2606    183129    rackmst rackmst_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.rackmst
    ADD CONSTRAINT rackmst_pkey PRIMARY KEY (rackid);
 >   ALTER TABLE ONLY public.rackmst DROP CONSTRAINT rackmst_pkey;
       public         postgres    false    241            �           2606    183131    rackmst rackmst_rackno_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.rackmst
    ADD CONSTRAINT rackmst_rackno_key UNIQUE (rackno);
 D   ALTER TABLE ONLY public.rackmst DROP CONSTRAINT rackmst_rackno_key;
       public         postgres    false    241            �           2606    167291 $   searchcondition searchcondition_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.searchcondition
    ADD CONSTRAINT searchcondition_pkey PRIMARY KEY (srno);
 N   ALTER TABLE ONLY public.searchcondition DROP CONSTRAINT searchcondition_pkey;
       public         postgres    false    227            �           2606    183139    shelfmst shelfmst_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.shelfmst
    ADD CONSTRAINT shelfmst_pkey PRIMARY KEY (shelfid);
 @   ALTER TABLE ONLY public.shelfmst DROP CONSTRAINT shelfmst_pkey;
       public         postgres    false    243            �           2606    167293    subdeptmst subdeptmst_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.subdeptmst
    ADD CONSTRAINT subdeptmst_pkey PRIMARY KEY (subdeptid);
 D   ALTER TABLE ONLY public.subdeptmst DROP CONSTRAINT subdeptmst_pkey;
       public         postgres    false    229            �           2606    167295    taggrpmst taggrpmst_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.taggrpmst
    ADD CONSTRAINT taggrpmst_pkey PRIMARY KEY (taggrpid);
 B   ALTER TABLE ONLY public.taggrpmst DROP CONSTRAINT taggrpmst_pkey;
       public         postgres    false    231            �           2606    167297     taggrpmst taggrpmst_taggrpnm_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.taggrpmst
    ADD CONSTRAINT taggrpmst_taggrpnm_key UNIQUE (taggrpnm);
 J   ALTER TABLE ONLY public.taggrpmst DROP CONSTRAINT taggrpmst_taggrpnm_key;
       public         postgres    false    231            �           2606    167299    tagmst tagmst_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tagmst
    ADD CONSTRAINT tagmst_pkey PRIMARY KEY (taggrpid, tagid);
 <   ALTER TABLE ONLY public.tagmst DROP CONSTRAINT tagmst_pkey;
       public         postgres    false    232    232            �           2606    167301    tagtypemst tagtypemst_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.tagtypemst
    ADD CONSTRAINT tagtypemst_pkey PRIMARY KEY (tagtypeid);
 D   ALTER TABLE ONLY public.tagtypemst DROP CONSTRAINT tagtypemst_pkey;
       public         postgres    false    234            �           2606    167303 %   tagtypemst tagtypemst_tagtypedesc_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.tagtypemst
    ADD CONSTRAINT tagtypemst_tagtypedesc_key UNIQUE (tagtypedesc);
 O   ALTER TABLE ONLY public.tagtypemst DROP CONSTRAINT tagtypemst_tagtypedesc_key;
       public         postgres    false    234            �           2606    167305    uacc uacc_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.uacc
    ADD CONSTRAINT uacc_pkey PRIMARY KEY (userid, mid);
 8   ALTER TABLE ONLY public.uacc DROP CONSTRAINT uacc_pkey;
       public         postgres    false    236    236            �           2606    167307    usermst usermst_emailid_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.usermst
    ADD CONSTRAINT usermst_emailid_key UNIQUE (emailid);
 E   ALTER TABLE ONLY public.usermst DROP CONSTRAINT usermst_emailid_key;
       public         postgres    false    237            �           2606    167309    usermst usermst_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.usermst
    ADD CONSTRAINT usermst_pkey PRIMARY KEY (userid);
 >   ALTER TABLE ONLY public.usermst DROP CONSTRAINT usermst_pkey;
       public         postgres    false    237            �           1259    167310 #   fki_FK_FileTagsData_ListData_ListNo    INDEX     h   CREATE INDEX "fki_FK_FileTagsData_ListData_ListNo" ON public.filetagsdata USING btree (listid, listno);
 9   DROP INDEX public."fki_FK_FileTagsData_ListData_ListNo";
       public         postgres    false    209    209            �           1259    167311     fki_FK_FileTagsData_TagMst_TagId    INDEX     f   CREATE INDEX "fki_FK_FileTagsData_TagMst_TagId" ON public.filetagsdata USING btree (taggrpid, tagid);
 6   DROP INDEX public."fki_FK_FileTagsData_TagMst_TagId";
       public         postgres    false    209    209            �           1259    167312 "   fki_Fk_FileTagsData_FileMst_FileId    INDEX     f   CREATE INDEX "fki_Fk_FileTagsData_FileMst_FileId" ON public.filetagsdata USING btree (fileid, seqno);
 8   DROP INDEX public."fki_Fk_FileTagsData_FileMst_FileId";
       public         postgres    false    209    209            �           2606    167313 ,   filetagsdata FK_FileTagsData_ListData_ListNo    FK CONSTRAINT     �   ALTER TABLE ONLY public.filetagsdata
    ADD CONSTRAINT "FK_FileTagsData_ListData_ListNo" FOREIGN KEY (listid, listno) REFERENCES public.listdata(listid, listno);
 X   ALTER TABLE ONLY public.filetagsdata DROP CONSTRAINT "FK_FileTagsData_ListData_ListNo";
       public       postgres    false    2978    209    209    221    221            �           2606    167318 )   filetagsdata FK_FileTagsData_TagMst_TagId    FK CONSTRAINT     �   ALTER TABLE ONLY public.filetagsdata
    ADD CONSTRAINT "FK_FileTagsData_TagMst_TagId" FOREIGN KEY (taggrpid, tagid) REFERENCES public.tagmst(taggrpid, tagid);
 U   ALTER TABLE ONLY public.filetagsdata DROP CONSTRAINT "FK_FileTagsData_TagMst_TagId";
       public       postgres    false    232    2992    232    209    209            �           2606    167323 +   filetagsdata Fk_FileTagsData_FileMst_FileId    FK CONSTRAINT     �   ALTER TABLE ONLY public.filetagsdata
    ADD CONSTRAINT "Fk_FileTagsData_FileMst_FileId" FOREIGN KEY (fileid, seqno) REFERENCES public.filemst(fileid, seqno);
 W   ALTER TABLE ONLY public.filetagsdata DROP CONSTRAINT "Fk_FileTagsData_FileMst_FileId";
       public       postgres    false    209    208    208    2959    209            �           2606    167328 &   classtaggrp classtaggrp_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.classtaggrp
    ADD CONSTRAINT classtaggrp_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 P   ALTER TABLE ONLY public.classtaggrp DROP CONSTRAINT classtaggrp_createdby_fkey;
       public       postgres    false    202    3002    237            �           2606    183153 !   compartmst compartmst_rackid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compartmst
    ADD CONSTRAINT compartmst_rackid_fkey FOREIGN KEY (rackid) REFERENCES public.rackmst(rackid);
 K   ALTER TABLE ONLY public.compartmst DROP CONSTRAINT compartmst_rackid_fkey;
       public       postgres    false    3004    241    245            �           2606    183158 "   compartmst compartmst_shelfid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compartmst
    ADD CONSTRAINT compartmst_shelfid_fkey FOREIGN KEY (shelfid) REFERENCES public.shelfmst(shelfid);
 L   ALTER TABLE ONLY public.compartmst DROP CONSTRAINT compartmst_shelfid_fkey;
       public       postgres    false    245    243    3008            �           2606    167333    filemst filemst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.filemst
    ADD CONSTRAINT filemst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 H   ALTER TABLE ONLY public.filemst DROP CONSTRAINT filemst_createdby_fkey;
       public       postgres    false    237    3002    208            �           2606    167338    filemst filemst_folderid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.filemst
    ADD CONSTRAINT filemst_folderid_fkey FOREIGN KEY (folderid) REFERENCES public.foldermst(folderid);
 G   ALTER TABLE ONLY public.filemst DROP CONSTRAINT filemst_folderid_fkey;
       public       postgres    false    2966    211    208            �           2606    167343 (   filetagsdata filetagsdata_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.filetagsdata
    ADD CONSTRAINT filetagsdata_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 R   ALTER TABLE ONLY public.filetagsdata DROP CONSTRAINT filetagsdata_createdby_fkey;
       public       postgres    false    209    3002    237            �           2606    167348 "   foldermst foldermst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.foldermst
    ADD CONSTRAINT foldermst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 L   ALTER TABLE ONLY public.foldermst DROP CONSTRAINT foldermst_createdby_fkey;
       public       postgres    false    3002    237    211            �           2606    167353    foldermst foldermst_deptid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.foldermst
    ADD CONSTRAINT foldermst_deptid_fkey FOREIGN KEY (deptid) REFERENCES public.deptmst(deptid);
 I   ALTER TABLE ONLY public.foldermst DROP CONSTRAINT foldermst_deptid_fkey;
       public       postgres    false    211    2953    204            �           2606    167358 $   hisfilemst hisfilemst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hisfilemst
    ADD CONSTRAINT hisfilemst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 N   ALTER TABLE ONLY public.hisfilemst DROP CONSTRAINT hisfilemst_createdby_fkey;
       public       postgres    false    3002    237    217            �           2606    167363 !   hisfilemst hisfilemst_fileid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hisfilemst
    ADD CONSTRAINT hisfilemst_fileid_fkey FOREIGN KEY (fileid, seqno) REFERENCES public.filemst(fileid, seqno);
 K   ALTER TABLE ONLY public.hisfilemst DROP CONSTRAINT hisfilemst_fileid_fkey;
       public       postgres    false    2959    217    208    208    217            �           2606    167368 (   hisfoldermst hisfoldermst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hisfoldermst
    ADD CONSTRAINT hisfoldermst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 R   ALTER TABLE ONLY public.hisfoldermst DROP CONSTRAINT hisfoldermst_createdby_fkey;
       public       postgres    false    3002    219    237            �           2606    167373 '   hisfoldermst hisfoldermst_folderid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hisfoldermst
    ADD CONSTRAINT hisfoldermst_folderid_fkey FOREIGN KEY (folderid) REFERENCES public.foldermst(folderid);
 Q   ALTER TABLE ONLY public.hisfoldermst DROP CONSTRAINT hisfoldermst_folderid_fkey;
       public       postgres    false    219    2966    211            �           2606    167378     listdata listdata_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.listdata
    ADD CONSTRAINT listdata_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 J   ALTER TABLE ONLY public.listdata DROP CONSTRAINT listdata_createdby_fkey;
       public       postgres    false    221    237    3002            �           2606    167383    listdata listdata_listid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.listdata
    ADD CONSTRAINT listdata_listid_fkey FOREIGN KEY (listid) REFERENCES public.listmst(listid);
 G   ALTER TABLE ONLY public.listdata DROP CONSTRAINT listdata_listid_fkey;
       public       postgres    false    221    2982    222            �           2606    167388    listmst listmst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.listmst
    ADD CONSTRAINT listmst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 H   ALTER TABLE ONLY public.listmst DROP CONSTRAINT listmst_createdby_fkey;
       public       postgres    false    222    3002    237            �           2606    167393 .   searchcondition searchcondition_tagtypeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.searchcondition
    ADD CONSTRAINT searchcondition_tagtypeid_fkey FOREIGN KEY (tagtypeid) REFERENCES public.tagtypemst(tagtypeid);
 X   ALTER TABLE ONLY public.searchcondition DROP CONSTRAINT searchcondition_tagtypeid_fkey;
       public       postgres    false    2994    227    234            �           2606    183140    shelfmst shelfmst_rackid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.shelfmst
    ADD CONSTRAINT shelfmst_rackid_fkey FOREIGN KEY (rackid) REFERENCES public.rackmst(rackid);
 G   ALTER TABLE ONLY public.shelfmst DROP CONSTRAINT shelfmst_rackid_fkey;
       public       postgres    false    243    241    3004            �           2606    167398 !   subdeptmst subdeptmst_deptid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subdeptmst
    ADD CONSTRAINT subdeptmst_deptid_fkey FOREIGN KEY (deptid) REFERENCES public.deptmst(deptid);
 K   ALTER TABLE ONLY public.subdeptmst DROP CONSTRAINT subdeptmst_deptid_fkey;
       public       postgres    false    2953    204    229            �           2606    167403 "   taggrpmst taggrpmst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.taggrpmst
    ADD CONSTRAINT taggrpmst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 L   ALTER TABLE ONLY public.taggrpmst DROP CONSTRAINT taggrpmst_createdby_fkey;
       public       postgres    false    237    3002    231            �           2606    167408    tagmst tagmst_createdby_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tagmst
    ADD CONSTRAINT tagmst_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.usermst(userid);
 F   ALTER TABLE ONLY public.tagmst DROP CONSTRAINT tagmst_createdby_fkey;
       public       postgres    false    237    3002    232            �           2606    167413    tagmst tagmst_listid_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.tagmst
    ADD CONSTRAINT tagmst_listid_fkey FOREIGN KEY (listid) REFERENCES public.listmst(listid);
 C   ALTER TABLE ONLY public.tagmst DROP CONSTRAINT tagmst_listid_fkey;
       public       postgres    false    222    2982    232            �           2606    167418    tagmst tagmst_tagtypeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tagmst
    ADD CONSTRAINT tagmst_tagtypeid_fkey FOREIGN KEY (tagtypeid) REFERENCES public.tagtypemst(tagtypeid);
 F   ALTER TABLE ONLY public.tagmst DROP CONSTRAINT tagmst_tagtypeid_fkey;
       public       postgres    false    232    2994    234            �           2606    167423    usermst usermst_deptid_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.usermst
    ADD CONSTRAINT usermst_deptid_fkey FOREIGN KEY (deptid) REFERENCES public.deptmst(deptid);
 E   ALTER TABLE ONLY public.usermst DROP CONSTRAINT usermst_deptid_fkey;
       public       postgres    false    2953    237    204            �           2606    167428    usermst usermst_desgid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usermst
    ADD CONSTRAINT usermst_desgid_fkey FOREIGN KEY (desgid) REFERENCES public.desigmst(desgid);
 E   ALTER TABLE ONLY public.usermst DROP CONSTRAINT usermst_desgid_fkey;
       public       postgres    false    206    237    2957            �           2606    167433    usermst usermst_groupid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usermst
    ADD CONSTRAINT usermst_groupid_fkey FOREIGN KEY (groupid) REFERENCES public.groupmst(groupid);
 F   ALTER TABLE ONLY public.usermst DROP CONSTRAINT usermst_groupid_fkey;
       public       postgres    false    2970    237    213            �           2606    167438    usermst usermst_hintid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usermst
    ADD CONSTRAINT usermst_hintid_fkey FOREIGN KEY (hintid) REFERENCES public.hintquestionmst(hintid);
 E   ALTER TABLE ONLY public.usermst DROP CONSTRAINT usermst_hintid_fkey;
       public       postgres    false    2972    237    215            Y   2   x���,.���4�*ILw/*�L2s�b`FZfNj<�����Zf��qqq �z�      Z      x������ � �      �      x������ � �      [   w   x�%�1�0@��>�OPn�@$h���.]��"Kĭ�?$]��������+�_B�$�N?NtdN���������x�Y��.�i+7�g�CDЭQ�j����*��Vj�G�Q�sC�,�&�      \   �  x��U�n�8<�����C���7?�Ā�1����ȌC�Lzi)���i��n,@b��Y��nFP��Lvm�� �X~1�H��&#�l�"�J6�L=��c�s��Xd�(��(̯�JjC����Z��[Ȉ#���W׶3�	&�.�}e�s����ԧ��V[�y�f9�#�#�i���6{�R�O'�iv��Ȯ}�N�Ԏ̬�z]�������t�A�������$����7�L��$�X�4I�]��}�V!!A_"�|�����:Gl�Mr�|T\���Ϫ��c�r_�E0�:ِuk��!Zdh������n~S��f,����@:�s��W�����4Fy����(b_�¼Zw��7z��7c�?�|B'��?;��Fi9Tʢ1�h��`�����*E
�>�{J宫/�*�&�/	qAE��&��Qu�t-�ߜ�pHi�g�P�w��� �4{m�r8P�!���?�Gpc�}`A������c~�C�i�GQ���)2uz/w��`������)�!�iڏO��F�c :�
X�fxzE�}��yNy��Z3�go�#�ЇЇ�/|�c�]���0����5�K5���X�u	Z�~�����u���?a1L6��ԷUD��/�sd��W�C�܆���7T0XZ���ݝ�F�������	��	���G
nL|Y<G@�D�%]A\3����'��:�k}��I�N�ҝ��(^��!�{=	 ��t�3�o�`=l���	�B���zN�t{���#ASo��`��LNz��ojN
�ː�2�b����iȪ������h�ќ���܋����wo��������ir1UI//��j��{������/;�l�`+J�xkl�%�'\6���6Ј��I�Ƙ����؜{+��/�
��ɯ�<vhkݏӛ=�?!#? �N�>v���l\����F�g	�{ph
����o:�~�]*]      ^   "  x��VMo�8=ӿB?�!�/Q��Q��F4=셕��XY�Jr���;C;�#��N �3o��0&���f�Z����&f���8�2�12�l���4у5͸�J�q5|]=?��ٞ����0v�y�x�t.�J�	�������0��!M-�Kg��[c�qk�t/nᗐ�2�R	����ѴcT���Z2/��4g����.��Oh*��I���۞� ^���,��dhM���0�E��Zk�h��z��>r��<�L�b�4`��)�,CͤFͲ7RᮘS���e�����Dߺ�~��}gƨ��ڙ5_|�LQ��B����CtO�y6�����Ҹ��cr��ſ�>��վ��X����
)���5/�+?�Hj�	��$���0��a�cy�i�aYB~���P�vD��j�Gw	�0�$�d}�ո:�n�n.���O�i'T�@LIe[��}��i,�Bx�������N�T*���b��bO�!XfT����l����GR9��Q�D-�V��vܚf�ց������aGqA�nU���_� 9����,�
��pI�fܾ�bϰ�&�I����q�
YJS-�lpͺwm���p�:IoeA��jr���ۯ!�$^Ɣ����ؙv �-a�0?�2R��UkT��$M%J"b���֟��TS0�X�,BQ#�����eB��S8��1��k��������D��޶H>^����8��!���}���UFE���9a	�<S&��X~	~�
uf���� b�	��b��|м��C;��m1i����A�7��W�9�s�����d�3��`o��v*�U.SP} a�����=�� t&?�Y߁�m���L����&�y2��Ǆ]�Nr.��P'X���,�@���+Ru�\�W�t���ʱ��.�������пXЮZ�8�"��8���Va4}s Q�qR�'DzE��B��#~���^�@W�38�?`���Q����i<�G���v~�\�{�B���]۵���*�V���a��pJiT8��X	�<��~;�v
�P{��Eg�����      `      x������ � �      a      x������ � �      c   B   x�3��5!� g_g�H À�H�XF���@�```Fe����y
i�9)�E�\1z\\\ ���      e   �  x�}��m�0Dϣ*�@~%97C���tJ�udg�G0�>p ��Ɍ���_()��)��J�Wϥ`��	T<�\����O\&�م�����9��wy�ϙ�U�s�5{�DNP�*&��Fo��,n�́V�nz	�"w�K��YLd��b"��-�?�s��,&���7p�b"Y��b"E�b"��ٖR�dK�z�e�i�T���L���D�|��Yi뀧Y��	ϲ�Tx�5<��-jXJ1�[�N�5M��M���4��zk� �������	d�q��k���k�rl��Rl=l�e���K�m�:,�ƣ�^,����z8x��4��@=�f9�;9�2��0�4�_n�碿=����'\[k��Ԛ�+ò��Ŋ�ۿ�eY��W��      g   /   x�3��H,Q�,V��/-Rp�,*.Q�K�M��2B��I����qqq '��      i      x������ � �      k      x������ � �      m   2   x�3�4���/Qp,(��LNL�I
Z�����q:r��qqq %�
�      n   1   x�3���/Qp,(��LNL�I�4�420��50"+0�t����� �
Q      o   �  x��V_k�H^
}�b��]�mql��/{��gKF�[���Js��G0�Ǒ�4�hp_r_E�vfgmɖD!ī���7�3�#��Ȟ�g�n���3���}T���m��� f/�}�o��a�ww���|�9�;������v��;贚�q_}��q�?��kh����c�hO�_���&
�p�>E�U��b6x���(�E�.�%7��?���(���id�q�I��h���,�Q�P»8�"�l&��Y' %fA�|�]��c3��� ���a�s ��f�	�ȭ��������:����U$�Y1�o/LYC>IB�� ���.�6� �ԛ���C�� �С,n!<��8��du,���g�!c����Y�²��[�	���DE�_"�<@����^�xp���ߚr_g^!y��rI�;@��Q.�@Ѯ�$v:*5R�Ü	�ͥ����\❒��|�7H5XYJ�\�=Yx)G�P�S�bE7�c�+�	�R�M��h�FB�XvxAK���w��3@�Տ
ZB�@potb;����_�t!�cϝ/��V.#|{e~�}a(�����N�T��F��V�z�}��^b7?�a�}&tud)KU�v�D�vj���p��X����j��3=C�h]'K	���-1{����T+�f���j�ZC���+�ϼ�KJ��)� ��� Iю�4MVM�klc_�]/`c2`$�z�Z̴r�����ꭱ�>IׄTJ���h���o'�~Fe�Q�d�I,Sr�Pn���l���DU�5�˃q�s)$!r#�5#s�'��uqw���k@��f��]70��ӱH���0���/�b���m�k��w��l����%ܕ�A+&+�����`�hB'b�r�%&��rg��1ʬ�[�ł]d_Y����o���l���U�^�G�'���/��|A��|�qgt�ܛ�Ѷ�A��� "�7P������-�e6>�'�	\�85��j�,e��x���4��
������      q      x������ � �      �   !   x�3�2�2�2�2�2�2�2����� 4J�      s   �   x�]��
�0���S��ҿ8���ѣ�!E�M��M��[/m~���% 8��r�bܽ��j�R/�9��Fô�B3�nq�6-l�����^�cކ�B;��AE�R�hX1e�Tpo�Hčܒ��Τ��21�,��9��y�|��{�*n����׈yLQJ �(.iF i���1�Y/g�+D���l|      �      x�3�4�t�2�N\ƜF@v� #��      u   �  x����n�H�ϡ��q��s㢛6/�Zh�ڨ�\�$Z�X&�r��~��R��B5`��_f�+M��E�z�=VO��d �߄�MJO��	���q�I�d$;`��gG����b,��1��Hu��m����r:?h�<��5�;fi�����%ۦ4Y#�X�1�8�̶۪�-\D�E��H�HH��������f���Ep`�d���ٹ*m�9M���7��`�(��%;�|���-;�y6�y_s{�E��ӝ7+r�x���GUGo��lY��yEӕ�J8������(��U�M���a���ّ:�*�A0�V�R	EL���c:G2_�@��z�⑰y*�:�ɬ� (�X���[�4��g���q��"��PQ̄�+�g�CJ�~Ɣ0vT���҅�80~FuP���bȈė�4L�1����𸖾���fH���uU��h�GN*?��<�6���p#��R���]��JdI��1{!E��
�|��|��,�8"�%&UG�����pi�,�x��|�k�.�M�=�ű���ƽɧ�($�f������c|�*��d�W�p�	?H'�!�BuX_����P�@�FwT�Q=}�>���3���j2j�f�K�G>�Z�.�F�%�7�!iC��q*A�&oo�<kX�<!�c�p%"�?��4wV��DX���,r�9�E���4-�lo�aX� �5�4�9-�nc�e��FL�\�n�;M��\7*찾sw��?[(�^��>��5���jb|7�q��e{>���L�i���6M��2�~����8��ܻHY���/\����� �� �x�$��dG��w d"�D�j�w�(%̍ n�k���.���=��2�#Ԛ䖠m�4��tZ���=����a��PHN�=�9&�$F�p#�Q���~xm�ar!H�UwP����.ý2���	5ݸ9��!NrE���>���8f[���؈���{E2֑/Yb�R#�o��,J���e���GP�!:���4����Rz����b�=�	}G&	).L��S��cZ�>����~rs�R�5)�},'˯���_�r�M�b��$1���ϲ�t[��-?h�Y`H��8�����ti�����9�]Es��y�>�'���'b���1=���P�����Y�b
ҵ�	�k���D�}J�s���2Q�[q�§K����;#/�ғ����n]�z��7k<��,��2wd��
ۋ$��V��9
����M�s����奺�J�����X�����5[^aB�Oq6"_֯��=�m��i=0_,��b \4(d	��>h=0�w7?@�+.��^/�.���)��S�m:aDal�:*�-C0WG��<��܌��m8�k��!˷T V�F��Ve]/�!ꤡ�=��E����7 ��!�����cZ�����c{�P�c؊6���۾q� l�����bڪ�Hh[~b���S��`k��S�� �&�^��%=���<���n�i��U���4�������]X��^�����z��Ҿ�Hw`��Bj�N��'���ݵ�+�u�z�U�39�	Ɏ���C��h=��ЄVŹ����V��qm���xЪ��C�jK��J�C"�0lk�}���o` I�b��=g�Ofz��F��+�f�7���v��_�����͟�K��������P��vO4��!���<��\�ҴR�߬m���=f}��X��֮������UbG�      w      x������ � �      x      x������ � �      z   ^   x�3��+�M-�L���U�t�2�tIM��M��tI�9s
2�s@�&�.�%��.% �)�knbfT�D}Rj	T�9�Ofq	�Xm� �&,            x��]Ys�H�~V�
Eܗ{#f����b@��c"&d�A6H�������̔ ;e�t�C��.���,�Y�W��f�8|��,����,P���,���[���Q�����ߓ�Z	V�$M�c���i���ah��x�R�Vq���;,��$]%qk�����W�%��1����bLԻI;hw��i��ak�oJ�z�V�j���mhJ;�S�.��j����TKY��x���Dv$�SfA�3��x�_�`�y�j�ŵ9��kJ"���$�n(���Q"��q�u�_oz�6<�R^[�z�B���=�w��>X�*�M�j�3f���|ʹ5�1�Ck��y�s	9M����zĄ�`�'���2Z��e�kB�35��|�1q���e�2��u۷���d1΃q?xݐ�uV�%_t�_�w��4ӳ}<�����4.�On���]k����T��� *���!x/yM�ȷm��=S'a�į�N�y�e��pi?�潇`�&�`x��j�q~ܯӣ������Y��dpDu�^n�l�mޔ���^,̓Ľd�x�S��>S'$j�Z�w��U�8������h�'�xA�@�>�gn�E e�@��"���C� \OY~����Y���1�w&��p���n��֩��
��^�`���g��.m���T���麞��/�f��HCu6yTJo�[�Z
"�����u�<{��Ǆ(b?�Th�aiV n�i�,���:��i�����w�5���&����-����������uJc�����_���,��^e�gx���pQ)a���|E�G��'E�o�n�Լ�ѕ�UK;������ P��颞�k�O�b	18&;�P:���^@*��~�HD����4^������
t�a��@�`>�b1H��t�k�P~��8V���R�6$⻶f:�ˮ���(Q��u�Q�MF��]�����8a��8�2�`K��UC�c^�=�sq��"F�1�;�MY�i(��`<�j����a��b��_'�^�ha��N�N�I��:W;�����m=�Uv���I���a�N�!�W2�*�u_ҡ��Z��j96n��V���=&S�Q�'�z8�	hq]Z`�,W��M�\G Lj�]OgOЫ�	�62��&�\(6 ��$Cc�=0�#�� �U8������\��b�~�JO�-&���,"�A�l��׹�Wte�Zn)R	��][`f��3� j�M1Tz�p72��W��>��$ǂ���T��e�H��.�����i+��������LVq�PQ7��-�c�m&eA��H�=r5.H��A�,n���8�Q�M�r]`�ì*��t�f`�A#��H��E� L�H(Z��ޙ;ô��G�1��	�.��$�:��3w��&kU �VB�� B��,2�н3B)��	�z�w����^?�m"=Xކ,��O�*$�����q}�'�c��;ta��p0�G:���`�oP�4�����}��M���\F`���,�:�`�o�{��:� ¤�h8�H?������^�Ne����\nT��0P��w�`ѣ�HD��m��Oڐ�<�o�N�i1�?!�i�0`���{���?�j�`���5p�="��� dNd�zH`G��&��X���@�e��+�~�MG>w��qM������D\����C�ȡ�i���2�C��Q �f4��[� "���� ���r�JW�܏�n�х�!��k��@�<�G�6��0����6�.ku�C'�|����`<�k���} ����gڠ#��)�1��t�[$:B��rm�	*�*�P.})���L��H_ p���J_��e�zɤ$�/�+��\��G��Bf��a�����)�|��u�ܟ�[|rG@R'���)ĉ��>��w���}�*���2\h:�w6�0��j���%	h�C%��e �1a�+�"F8�a���$���ȡ���#E �EXO�p@<�i�wi���EQ�;�ܰ��������n���C!CV���p��n�]�!Ѕ�4Ɠ���'�)����ʊ��x���n��;um
�����o
bS���ɘBF�>�o9 Xdt��𹮔X&�˕��r|�w2�)�ZU�SlSD�I�q�t{#z����6�����J�Di��r����<��b_�t�T��E�f`M�ݎ��j�_H�����i�K�����Q��^�,�s+-O#E�"�<�-K��T�V�AŠ7��!�A�Պ-���ѩ؉N�n���u.L�4����X��YZ�Ӓ!M|s̳�z���}\��s�o��7=r#]@�?r_�X�,�R#V>t�W�� Z�	���b�'I�Ա\C�u�V��9� ��ϸ0�mk�.b	��!��b©xE��)�:����YJ[y�Mv�D����E8�Lk����L�����^��j�Y�*��o9�g�b��`�GKh)	�/=�r� 5e(U���.H���?C \��~K.+$�`9�V��]$�����"����|]�@d�Br��#��Ψ.��pK�16�A~��Ч8-�V[W���G�H/��|�xn0�nȄ~��B�d��J��,f��@�s8%Y�/�
��S�FAl(r	�ھ-0�E���?6���M���{���|�.�F�3�*@t+�T�>����.|�0^��k�
���hʊ�
dU�����%!�����nP�.+��KV��9�CI��v~��x�T��*c��;���3V)x��P���N��t�w��ᗤ.T��/�������Cw4�ď�� �~���/`�I����bR��7�['�ۉ9D,��L�Ѐ,Ye�1a��ޤ�"���l��6{��i�WV���F>��xp_j9�W��|�7xt�9����i����RC���YVQ�����"�5ptY�EI�"ǂ���I^E�s�F��ڀ��D�u.M�w��/�8+�Q�<�����^&`n��7Lʹm@�U;��S�sInCzQX��er��_�������g�El���m[SD�[���E0U��Sv�Շ��w���\�u����L��F��
[�teћ�(���N�A]ڶ���tL^�_���>�s�YJ�q���D5?Y�$Q|9.�km���`Y�I��D�g�L㞤��@���t�bޣhГ�s��x��'e�?I3�a�#�,�����Uд&����t��ɥk.a���n��H�o�E�!�ݓ<Z�D,���lp���Dv���j��j�SD&쎪p*��->�`�ʺ��s���jX�顔DA_y��<�7����Is�����ZÆJ��Y��������z�=��ܡ�Y%+܇�A�j��پEʠ\�.^�H˹]�_�ǡ�>*���B-��K�����s�}���w��1x_-�G8ʾU����M2��a��"�S��y��&Qr���	[8�ʁ��՞������P*"�G�M2�<�L��!A�^��7f8����)HG���ED��Y�#x�L͑c�|�+'��BQ���&T�4������ʨ4���j�^�� s�Y�\!�o!��K��D�I��\\�4�S?�5��,�OJ��,��-S)�I��Tl��2�I����B�:-�R�]�5�Y4.!٧���v�����;�2��
�>B�ڿ�,�P�>,e�T�w!t�9�"��k���2��bT�V�c@�S�j����8����K��l��J���ŇR}�P^�
�����=�%����ɯ��D�|�&�׫r�3jN����+q�P�У[�ͿZաU]�
a:��	�""��XR�yٮ�Wu�m���TS��Ś�#Q��Ň�����|kU��e1�ڥ֎EK]�3J)��Z�W={VTL�-2�T�5��L�,*��>YK��&r�L����E(V.~/�jw0�t��KKTk{�yi���w|�]�Js���E��uU�_�
L��0LV�]���N�� �'�βo5�f=�r?����
�.[�-tU��3���DC*��j�'�<:��29`��z���q��{:��V[��S�9�レ��5�axn��ǚ    ��䰥ژ��o@�pp�Ys�ӽh�V��W-�:���GoO�UnX{��Y�Zf� F�I�R6� ��N͍��e+����5)�`�v���+^�������K�|�֛ƀ[��L~p�'�KJ���G�G��w���2��cϦx�k��r�"g�q\�o9H��{�qu(�=����貞B�ǻ$[
Zn�r?���T3JZ�O9g�S�h\ҙ�g1�I�g��x�E��Q���0�m
��Y�z<g��{&@j迕��c��@�yce.�lŽ*�*pQ7���d}Z�-�l��I�[�k��l�S��śg]F��h��@�p6H�&,<-]}�,���cs��e��)CV��S�T��������y��d��?��F�y�䲽4b���LY��1,�hN���-j6���=���t�� �(��4���G�W��j?$؏>l^g8駴����U���\���3b���A�����֠�|�T�)=VU��y�tJ��CL��e�(j;�iI�J��le��5CS�}�b-��K��c_p�M�ʀ��Oۇ�����t�Z���[����Ń̷�jJPo��DI�7�}��9��?"�r���u�t��`vN�(���Wk@u�Z:א6�W�VwB�bȆ��)<c�˽K�&�U�ʢƟY4�S��܏�m� ^��tV�lx>#�XwW�_�\�j�� K�4�m���d��*R�����7_��UC;�B�B����S+M^��G1���`QHQ�P����㲯��F�@�]��V�� ���hJ�{��2�l�����x-z������/8����L��F�Arm{�B� W���o�4��%�C���

 �Ξ�\ÂM&�-���(1�khEG�]S�K�4T��%^tKWɁaFD�՛���U{W�'��<-��P���7�^���D^��nxΤu��iUȲǼ|��/�VL��쓞��C�I����	z��^H�6�)~&r�uDy��d�EO����dhx�}��l���2\�0=�|#�ˆ�u����/���kk.�	&F�����z}^H7���_�&�(d.�ʎ�����C��\��E��B}�ش�����#9`��G܎���4�T��3I!�"ޚ�
.-�s-%N��]��B�y���l�k��TL_�+&���Fs,������]��XA�.>]�.���m��m�%��6]�w��m��y۔Wn���݅�~_ְ6�7�� �����֓������㙀�cpFx]"�o~PG3b�����q�/�{:��3h`!*m~T
�>Ѻ�x�Y�Դ���b�p��L{����Ӟ�?���t�
$�ط,�ذʗ����6����b���
0�e�g*����#��OŎ�u8	j��P�Aj�o�:*��Nhx�-���;��νڮ�y�|��[]�3�M��l�6��Uq�'<�h�H1	g����sޱ��Pďkv 2C���nD�DK9^�w\~C��QbHO��#�Ns����m��˫���bK��F=��=��G��Q,;�}g��.�b�B����=���-U���fH�&�y���6N������� u�Y.<�yp�\��6�2mG�2�"_t��P� 1�MR|K��J���$�q�6���-�t-DCህ,i=������>9���o����~��f_�jUy��Mٟ��چ��<e�z��-O����hi�.�t�`�4<���Ϩ�����Wo@�X�k�e��&I
����0��JZ^ܫBJk�����.s�±�4Ue?skko�� �ue���H��xiq �E���H�>�f��9�a�o�4;,��"���(� ȥ���f�����x������)H��TiK�3����-_��g։��u W������_��P�,�xT�����4�����2� W	:}���B���6Fw`u۳K�n����Y��1	�x�mX�犪 ���?Y�ɻ`/������OY�Ys\N3�l�g� =�_�7�wX���mn�\ǀnt���k�X��b
T4��/��gG��QFS����[?�i��B�"��_�U�h��)��]����2k�Ln���A��,#^�R�6o�z���ʪ/�Ɏ�i�W�_�;��;��?�>��'�6�f��teP�����u<�R�A���i؞�]�K�<��l�|�^��I�YyE���6�X��7�ɦI���1�N���,�5��9����ij�f]����k:���pp�r)ͧ�= ����B(c V�ྩK����tCL���:�x�[@��t�sq�4���qu�5�wtq��a^D+�,=9�ꗠ{�~5��i�EV��M҂+��I�}WH�c)�Y@���L�L��IۀxNu�z5Qh1GwZ.c�?�/�'��|��5~N޹�MR�V�|�Z9Mh04���S��*[���W�6Ͻ��#֩���vُ��<%jȘ��b�'-��U�V���E� "ߝ�M�i*�a������2�ɞ��t,[��;=&O���vcD�����.��6�JD�;W<�T 
�Y&�3��˿��6��� �c����"�*�����U������<j���/N�<y�O�w����!�M&S�x�÷8-��:P�o(E�3γ찹�o����E��(��3�A}�A��<���*[.��5�q^1+0��|<44�J�Y��y���i��8	�̊&��(B��i��t��9�r�ƫS��/�ɣ��jvC٨|ǂ��\�#f"�J3/�ApS���D!�zob�K���>_���.��-�缻��-�ߤِ&��,
"��*d�������//�(�+qP��-Zݳ<��^c����4{}�]����#�E-�R��3m(A����ꍍ���v���R�6Q�i�7!��d��Cu4�	���i�%�
�G��/���H��8�BJD�X=��D�Uc�F���C�G��ԆO �u�"TP��FT�?�?5�	����i�!^z�_��
?ӫ;�= ���D�a�� O��/�A�wܗ�qMj�aq�(�S6'��RV{���eV}=Ϩ��G�"g.�rS�]hB���M	���؅:�4?�u�2_���X��T����ʦZ�\.S	'��Sv5�i#�^Ѵ�'�<s����*��J����K�
c��ۈ�'w�HP�w5|E�5(yW����+�籫E0=��Wj����gu�x꼶Q����y����6��s=��Ue/0�k��t����Xf�E�DT���31ҹbⲶ�.�.��+�,�ef�̩mH^����A>��a���C��+�oH�­[�X�,��(?t������>���<����Euo����Q*�P��x��}ּc*����-ӌƧ5�䗾��Qk�`�/Ci0Ġ��iL�(LM[�8���M��Ռ��K���	��UZ]fZ��\Vϔ�8'w�U�n$O�U������+��BX;`#-��G��S���uI����љ�F!m��� P�!�����4E�1yS�d�����W��jZ:��(e��Nফ!�,�G�5��kעSp=�[�
V5�X<�4E����y���q�5�D���A�첚!sM�`���)�N�3� ?���!�U~n�L�h�lH�n3}�}����G|��,����]n�rK?����4�����Y7�Uh�&�n�ү�5�/���qI�E�y9�L�.��P��̟�K�������C�[s�RDm��:�վLW>�K�뺇7P���i�=C��ջx����Ű�yT�����eU�N�;���`�u�S�/��q}.=Kw����$f�_�X��\��)?� �7��4��j�
ꃴ�kنk[��#����R���$� ߔP-�!j����}0�A�6�\��6��fO�R=�\@}e�.�Cx������	Ղ<��S~Uw����4�b
��L���$�~�n��c��J��*��A���2Ѵm��Z�|��${���mИ�"~�ir���J$a-��{|��ȁ�ᙎ�]G�|�Io2��^䵕m3��Nӭ �   \tȖ~��'���������O���̈́,j��K7t_��s1�Ƣ��yt5�Pl��>d�T�<�!����~���']��'mm�㱦)��cDd��^��#*���1��z�I54,���xs]���/����@��      |   |   x�]�;�0���>LdC�G����ϑ*�~���������5�Oeٻ�~�/�G�V&RU�V��L`��8$NGS�l�:����B�p2��E��t��k�p&/���M�j�Ӵ�������c�y��[�      }   T   x�3�t-�qL���s(I-.�K���Lq9J�R9�� ��M8c�@��F�$9�-u�H���
�8A��b���� ��4     