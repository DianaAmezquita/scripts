create or replace package body bio is
    
        procedure login (userne in BIO_USER.USERNAME%type,
                                        phone in BIO_LOG_ENTRY.UUID_PHONE%type,
                                        id_fingerp out varchar2,
                                        p_var OUT VARCHAR2)
                                        
        is
            usern varchar2(20):=null;
          BEGIN
            select username
            into usern
            FROM bio_user 
            where username = userne;

            id_fingerp:= to_char(BIO_LOG_ENTRY_SEQ.nextval);

            insert into bio_log_entry 
            values (id_fingerp,null,userne,sysdate,phone,sysdate,userne,sysdate,sysdate,userne,null);

            p_var := 'true';
            DBMS_OUTPUT.PUT_LINE (p_var);
            
            --     DBMS_OUTPUT.PUT_LINE (id_fingerp);

            EXCEPTION
              WHEN OTHERS
              THEN
                 p_var := 'false';
            DBMS_OUTPUT.PUT_LINE(p_var);

        end login;
        
        procedure huella (una in BIO_LOG_USER_FINGERP.UNAME%type,
        finger_tem in BIO_LOG_USER_FINGERP.FINGERPRINT_TEMPLATE%type,
        finger_im in BIO_LOG_USER_FINGERP.FINGERPRINT_image%type,
        id_user out varchar2,
        p_var OUT VARCHAR2)
        is
        begin
            id_user:= to_char(BIO_LOG_USER_FINGERP_SEQ.nextval);

            insert into BIO_LOG_USER_FINGERP 
            values (id_user,una,finger_tem,finger_im,sysdate,una,sysdate,sysdate,una,null);

            p_var := 'true';
            DBMS_OUTPUT.PUT_LINE (p_var);

            -- DBMS_OUTPUT.PUT_LINE (id_user);
            
            EXCEPTION
              WHEN OTHERS
              THEN
                 p_var := 'false';
                 DBMS_OUTPUT.PUT_LINE(p_var);

        end huella;
        
        procedure prepago (fingerp_tem in bio_customer_fingerp.fingerprint_template%type,
        fingerp_im in bio_customer_fingerp.fingerprint_image%type,
        usern in BIO_DATA_CUSTOMER.USERNAME%type,
        face_p in BIO_DATA_CUSTOMER.FACE_PICTURE%type,
        dni_p in BIO_DATA_CUSTOMER.dni_PICTURE%type,
        sing_p in BIO_DATA_CUSTOMER.SIGNATURE_picture%type,
        id_cust in BIO_CUSTOMER.ICUSTOMER%type,
        id_cust_a in BIO_CUSTOMER_ASSET.ID_ASSET_CUSTOMER%type,
        id_cont in BIO_CUSTOMER_ASSET.ID_CONTRACT%type,
        res_type in BIO_CUSTOMER_ASSET.REGISTER_TYPE%type,
        id_dacu out varchar2,
        id_cusfin out varchar2,
        p_var OUT VARCHAR2)
        
        is
        begin
            id_cusfin:= to_char(bio_customer_fingerp_SEQ.nextval);

            insert into bio_customer_fingerp
            values (id_cusfin,fingerp_tem,fingerp_im,sysdate,usern,sysdate,sysdate,usern,null);

            id_dacu:= to_char(BIO_DATA_CUSTOMER_SEQ.nextval);

            insert into BIO_DATA_CUSTOMER 
            values (id_dacu,usern,id_cusfin,face_p,dni_p,sing_p,null,sysdate,null,null,sysdate,usern,sysdate,sysdate,usern,null);

            insert into BIO_CUSTOMER 
            values (id_dacu,id_cust,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);
            
            insert into BIO_CUSTOMER_ASSET 
            values (id_dacu,id_cust,id_cont,res_type,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);

            p_var := 'true';
            DBMS_OUTPUT.PUT_LINE (p_var);
            
            EXCEPTION
              WHEN OTHERS
              THEN
                 p_var := 'false';
                 DBMS_OUTPUT.PUT_LINE(p_var);
        
        end prepago;
        
        procedure prepago_discap (
        fingerp_temp_d in bio_rep_fingerp_discap.fingerprint_template%type,
        fingerp_im_d in bio_rep_fingerp_discap.fingerprint_image%type,
        face_p_d in bio_rep_discap.face_picture%type,
        dni_p_d in bio_rep_discap.dni_picture%type,
        sing_p_d in bio_rep_discap.singnature_picture%type,
        usern in BIO_DATA_CUSTOMER.USERNAME%type,
        face_p in BIO_DATA_CUSTOMER.FACE_PICTURE%type,
        dni_p in BIO_DATA_CUSTOMER.dni_PICTURE%type,
        sing_p in BIO_DATA_CUSTOMER.SIGNATURE_picture%type,
        pic_d in BIO_DATA_CUSTOMER.picture_discap%type,
        id_cust in BIO_CUSTOMER.ICUSTOMER%type,
        id_cust_a in BIO_CUSTOMER_ASSET.ID_ASSET_CUSTOMER%type,
        id_cont in BIO_CUSTOMER_ASSET.ID_CONTRACT%type,
        res_type in BIO_CUSTOMER_ASSET.REGISTER_TYPE%type,
        id_discap out varchar2,
        id_finge out varchar2,
        id_dacu out varchar2,
        id_cusfin out varchar2,
        p_var OUT VARCHAR2)
        
        is
        begin
        
            id_finge:= to_char(bio_rep_fingerp_discap_SEQ.nextval);
            
            insert into bio_rep_fingerp_discap
            values (id_finge,fingerp_temp_d,fingerp_im_d,sysdate,usern,sysdate,sysdate,usern,null);
            
            id_discap:= to_char(bio_rep_discap_SEQ.nextval);

            insert into bio_rep_discap
            values (id_discap,id_finge,face_p_d,dni_p_d,sing_p_d,sysdate,usern,sysdate,sysdate,usern,null);
            
            id_dacu:= to_char(BIO_DATA_CUSTOMER_SEQ.nextval);

            insert into BIO_DATA_CUSTOMER 
            values (id_dacu,usern,null,face_p,dni_p,sing_p,id_discap,sysdate,null,pic_d,sysdate,usern,sysdate,sysdate,usern,null);

            insert into BIO_CUSTOMER 
            values (id_dacu,id_cust,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);
            
            insert into BIO_CUSTOMER_ASSET 
            values (id_dacu,id_cust,id_cont,res_type,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);
            
            p_var := 'true';
            DBMS_OUTPUT.PUT_LINE (p_var);
            
            EXCEPTION
              WHEN OTHERS
              THEN
                 p_var := 'false';
                 DBMS_OUTPUT.PUT_LINE(p_var);
        
        end prepago_discap;
        
        procedure postpago (
        fingerp_tem in bio_customer_fingerp.fingerprint_template%type,
        fingerp_im in bio_customer_fingerp.fingerprint_image%type,
        usern in BIO_DATA_CUSTOMER.USERNAME%type,
        face_p in BIO_DATA_CUSTOMER.FACE_PICTURE%type,
        dni_p in BIO_DATA_CUSTOMER.dni_PICTURE%type,
        sing_p in BIO_DATA_CUSTOMER.SIGNATURE_picture%type,
        id_cust in BIO_CUSTOMER.ICUSTOMER%type,
        id_cust_a in BIO_CUSTOMER_ASSET.ID_ASSET_CUSTOMER%type,
        id_cont in BIO_CUSTOMER_ASSET.ID_CONTRACT%type,
        res_type in BIO_CUSTOMER_ASSET.REGISTER_TYPE%type,
        bank_data in BIO_BANK_DATA.BANK_DATA_TYPE%type,
        tdc_a in BIO_BANK_DATA.TDC_ADVERSE%type,
        tdc_r in BIO_BANK_DATA.TDC_REVERSE%type,
        ACC_S in BIO_BANK_DATA.ACCOUNT_STATUS%type,
        id_bank out varchar2,
        id_dacu out varchar2,
        id_cusfin out varchar2,
        p_var OUT VARCHAR2)
        
        is
        begin
            id_cusfin:= to_char(bio_customer_fingerp_SEQ.nextval);

            insert into bio_customer_fingerp
            values (id_cusfin,fingerp_tem,fingerp_im,sysdate,usern,sysdate,sysdate,usern,null);

            id_bank:= to_char(BIO_BANK_DATA_SEQ.nextval);

            insert into BIO_BANK_DATA
            values (id_bank,bank_data,tdc_a,tdc_r,acc_s,sysdate,usern,sysdate,sysdate,usern,null);

            id_dacu:= to_char(BIO_DATA_CUSTOMER_SEQ.nextval);

            insert into BIO_DATA_CUSTOMER 
            values (id_dacu,usern,id_cusfin,face_p,dni_p,sing_p,null,sysdate,id_bank,null,sysdate,usern,sysdate,sysdate,usern,null);

            insert into BIO_CUSTOMER 
            values (id_dacu,id_cust,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);
            
            insert into BIO_CUSTOMER_ASSET 
            values (id_dacu,id_cust,id_cont,res_type,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);

            p_var := 'true';
            DBMS_OUTPUT.PUT_LINE (p_var);
            
            EXCEPTION
              WHEN OTHERS
              THEN
                 p_var := 'false';
                 DBMS_OUTPUT.PUT_LINE(p_var);
        
        end postpago;
        
        procedure postpago_discap(fingerp_temp_d in bio_rep_fingerp_discap.fingerprint_template%type,
        fingerp_im_d in bio_rep_fingerp_discap.fingerprint_image%type,
        face_p_d in bio_rep_discap.face_picture%type,
        dni_p_d in bio_rep_discap.dni_picture%type,
        sing_p_d in bio_rep_discap.singnature_picture%type,
        usern in BIO_DATA_CUSTOMER.USERNAME%type,
        face_p in BIO_DATA_CUSTOMER.FACE_PICTURE%type,
        dni_p in BIO_DATA_CUSTOMER.dni_PICTURE%type,
        sing_p in BIO_DATA_CUSTOMER.SIGNATURE_picture%type,
        pic_d in BIO_DATA_CUSTOMER.picture_discap%type,
        id_cust in BIO_CUSTOMER.ICUSTOMER%type,
        id_cust_a in BIO_CUSTOMER_ASSET.ID_ASSET_CUSTOMER%type,
        id_cont in BIO_CUSTOMER_ASSET.ID_CONTRACT%type,
        res_type in BIO_CUSTOMER_ASSET.REGISTER_TYPE%type,
        bank_data in BIO_BANK_DATA.BANK_DATA_TYPE%type,
        tdc_a in BIO_BANK_DATA.TDC_ADVERSE%type,
        tdc_r in BIO_BANK_DATA.TDC_REVERSE%type,
        ACC_S in BIO_BANK_DATA.ACCOUNT_STATUS%type,
        id_bank out varchar2,
        id_discap out varchar2,
        id_finge out varchar2,
        id_dacu out varchar2,
        id_cusfin out varchar2,
        p_var OUT VARCHAR2)
        
        is
        begin
        id_finge:= to_char(bio_rep_fingerp_discap_SEQ.nextval);
            
            insert into bio_rep_fingerp_discap
            values (id_finge,fingerp_temp_d,fingerp_im_d,sysdate,usern,sysdate,sysdate,usern,null);
            
            id_discap:= to_char(bio_rep_discap_SEQ.nextval);

            insert into bio_rep_discap
            values (id_discap,id_finge,face_p_d,dni_p_d,sing_p_d,sysdate,usern,sysdate,sysdate,usern,null);
            
            id_bank:= to_char(BIO_BANK_DATA_SEQ.nextval);

            insert into BIO_BANK_DATA
            values (id_bank,bank_data,tdc_a,tdc_r,acc_s,sysdate,usern,sysdate,sysdate,usern,null);
            
            id_dacu:= to_char(BIO_DATA_CUSTOMER_SEQ.nextval);

            insert into BIO_DATA_CUSTOMER 
            values (id_dacu,usern,null,face_p,dni_p,sing_p,id_discap,sysdate,id_bank,pic_d,sysdate,usern,sysdate,sysdate,usern,null);

            insert into BIO_CUSTOMER 
            values (id_dacu,id_cust,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);
            
            insert into BIO_CUSTOMER_ASSET 
            values (id_dacu,id_cust,id_cont,res_type,1,sysdate,sysdate,usern,sysdate,sysdate,usern,null);
            
            p_var := 'true';
            DBMS_OUTPUT.PUT_LINE (p_var);
            
            EXCEPTION
              WHEN OTHERS
              THEN
                 p_var := 'false';
                 DBMS_OUTPUT.PUT_LINE(p_var);   
        
        end postpago_discap;

end bio;