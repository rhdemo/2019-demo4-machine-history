--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    user_id character varying(255) NOT NULL,
    type character varying(32) NOT NULL,
    linked_on timestamp without time zone,
    used_on timestamp without time zone,
    nonce character varying(255)
);


--
-- Name: acl; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acl (
    user_id character varying(255) NOT NULL,
    design_id bigint NOT NULL,
    role character varying(255) NOT NULL
);


--
-- Name: acl_invites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE acl_invites (
    created_by character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    created_by_display character varying(255),
    design_id bigint NOT NULL,
    role character varying(16) NOT NULL,
    invite_id character varying(64) NOT NULL,
    status character varying(16) NOT NULL,
    modified_by character varying(255),
    modified_on timestamp without time zone,
    subject character varying(1024)
);


--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- Name: api_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_content (
    design_id bigint NOT NULL,
    version bigint NOT NULL,
    type smallint NOT NULL,
    data text NOT NULL,
    created_by character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    reverted smallint DEFAULT 0 NOT NULL,
    modified_on timestamp without time zone
);


--
-- Name: api_content_version_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_content_version_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_content_version_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_content_version_seq OWNED BY api_content.version;


--
-- Name: api_designs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_designs (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(1024),
    created_by character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    tags character varying(2048),
    api_type character varying(255) NOT NULL
);


--
-- Name: api_designs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_designs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_designs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_designs_id_seq OWNED BY api_designs.id;


--
-- Name: apicurio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE apicurio (
    prop_name character varying(255) NOT NULL,
    prop_value character varying(255)
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL
);


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- Name: codegen; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE codegen (
    id bigint NOT NULL,
    created_by character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    modified_by character varying(255),
    modified_on timestamp without time zone,
    design_id bigint NOT NULL,
    ptype character varying(64) NOT NULL,
    attributes text NOT NULL
);


--
-- Name: codegen_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE codegen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: codegen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE codegen_id_seq OWNED BY codegen.id;


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(4000),
    user_id character varying(36),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT NULL::character varying
);


--
-- Name: credential_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


--
-- Name: fed_credential_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(255),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT 'HmacSHA1'::character varying,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE migration_model (
    id character varying(36) NOT NULL,
    version character varying(36)
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    last_session_refresh integer,
    offline_flag character varying(4) NOT NULL,
    data text
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL
);


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255)
);


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(36) NOT NULL,
    requester character varying(36) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(36)
);


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255),
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: session_uuids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE session_uuids (
    uuid character varying(255) NOT NULL,
    design_id bigint NOT NULL,
    user_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    version bigint NOT NULL,
    expires_on bigint NOT NULL
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: api_content version; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_content ALTER COLUMN version SET DEFAULT nextval('api_content_version_seq'::regclass);


--
-- Name: api_designs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_designs ALTER COLUMN id SET DEFAULT nextval('api_designs_id_seq'::regclass);


--
-- Name: codegen id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY codegen ALTER COLUMN id SET DEFAULT nextval('codegen_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY accounts (user_id, type, linked_on, used_on, nonce) FROM stdin;
stuart.w.douglas@gmail.com	GitHub	2019-04-04 05:47:13.742	\N	\N
\.


--
-- Data for Name: acl; Type: TABLE DATA; Schema: public; Owner: -
--

COPY acl (user_id, design_id, role) FROM stdin;
stuart.w.douglas@gmail.com	1	owner
\.


--
-- Data for Name: acl_invites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY acl_invites (created_by, created_on, created_by_display, design_id, role, invite_id, status, modified_by, modified_on, subject) FROM stdin;
\.


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: api_content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY api_content (design_id, version, type, data, created_by, created_on, reverted, modified_on) FROM stdin;
1	1	0	{\n  "openapi" : "3.0.2",\n  "info" : {\n    "title" : "Machine History Initial v3",\n    "version" : "1.0.0"\n  },\n  "paths" : {\n    "/machines" : {\n      "get" : {\n        "summary" : "Gets a list of all machines",\n        "operationId" : "getAllMachines",\n        "responses" : {\n          "200" : {\n            "description" : "The list of machine ID's",\n            "content" : {\n              "application/json" : {\n                "schema" : {\n                  "type" : "array",\n                  "items" : {\n                    "$ref" : "#/components/schemas/Machine"\n                  }\n                }\n              }\n            }\n          }\n        }\n      }\n    },\n    "/machines/history/{id}" : {\n      "get" : {\n        "operationId" : "machineHistory",\n        "responses" : {\n          "200" : {\n            "content" : {\n              "application/json" : {\n                "schema" : {\n                  "$ref" : "#/components/schemas/MachineHistory"\n                }\n              }\n            }\n          }\n        }\n      },\n      "parameters" : [ {\n        "name" : "id",\n        "in" : "path",\n        "required" : true,\n        "schema" : {\n          "type" : "integer"\n        }\n      } ]\n    },\n    "/machines/{id}" : {\n      "get" : {\n        "responses" : {\n          "200" : {\n            "content" : {\n              "application/json" : {\n                "schema" : {\n                  "$ref" : "#/components/schemas/MachineState"\n                }\n              }\n            }\n          }\n        }\n      },\n      "parameters" : [ {\n        "name" : "id",\n        "in" : "path",\n        "required" : true,\n        "schema" : {\n          "type" : "integer"\n        }\n      } ]\n    }\n  },\n  "components" : {\n    "schemas" : {\n      "MachineState" : {\n        "description" : "The representation of the current state of a machine",\n        "required" : [ "id", "name", "health" ],\n        "type" : "object",\n        "properties" : {\n          "id" : {\n            "description" : "The machine ID",\n            "type" : "integer"\n          },\n          "name" : {\n            "description" : "The machine name",\n            "type" : "string"\n          },\n          "health" : {\n            "description" : "The machine health",\n            "type" : "integer"\n          }\n        }\n      },\n      "Machine" : {\n        "description" : "A Machine",\n        "required" : [ "id", "name" ],\n        "type" : "object",\n        "properties" : {\n          "id" : {\n            "format" : "int32",\n            "description" : "The Machine ID",\n            "type" : "integer"\n          },\n          "name" : {\n            "description" : "The machine name",\n            "type" : "string"\n          }\n        }\n      },\n      "MaintenanceData" : {\n        "description" : "A record of maintenance performed on a machine",\n        "required" : [ "id", "date", "repair", "mechanic" ],\n        "type" : "object",\n        "properties" : {\n          "id" : {\n            "type" : "integer"\n          },\n          "date" : {\n            "type" : "string"\n          },\n          "mechanic" : {\n            "type" : "string"\n          },\n          "repair" : {\n            "type" : "integer"\n          },\n          "finalHealth" : {\n            "type" : "integer"\n          }\n        }\n      },\n      "MachineHistory" : {\n        "description" : "The history of a machine",\n        "required" : [ "maintenance", "name" ],\n        "type" : "object",\n        "properties" : {\n          "maintenance" : {\n            "type" : "array",\n            "items" : {\n              "$ref" : "#/components/schemas/MaintenanceData"\n            }\n          },\n          "name" : {\n            "type" : "string"\n          }\n        }\n      }\n    }\n  }\n}	stuart.w.douglas@gmail.com	2019-04-04 05:46:37.822	0	\N
\.


--
-- Name: api_content_version_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('api_content_version_seq', 1, true);


--
-- Data for Name: api_designs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY api_designs (id, name, description, created_by, created_on, tags, api_type) FROM stdin;
1	Machine History Initial v3	\N	stuart.w.douglas@gmail.com	2019-04-04 05:46:37.822	\N	OpenAPI30
\.


--
-- Name: api_designs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('api_designs_id_seq', 1, true);


--
-- Data for Name: apicurio; Type: TABLE DATA; Schema: public; Owner: -
--

COPY apicurio (prop_name, prop_value) FROM stdin;
db_version	8
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
b342ce5c-813a-40c5-9ae6-bd40feece608	\N	auth-cookie	master	14fc0101-93a1-4fb8-907a-baf3e1f2bc67	2	10	f	\N	\N
253ae60d-edd9-4b0b-930f-d8932697f2b8	\N	auth-spnego	master	14fc0101-93a1-4fb8-907a-baf3e1f2bc67	3	20	f	\N	\N
b4cb3975-bff0-4c28-af02-f323a782ef6e	\N	identity-provider-redirector	master	14fc0101-93a1-4fb8-907a-baf3e1f2bc67	2	25	f	\N	\N
540c478d-de05-4561-a983-5df5b7aa5e2b	\N	\N	master	14fc0101-93a1-4fb8-907a-baf3e1f2bc67	2	30	t	5175eba9-6a66-4fa3-9d9e-6c9ba9bc1426	\N
42a200cb-ba67-41c9-baa3-dfefbd5d93b1	\N	auth-username-password-form	master	5175eba9-6a66-4fa3-9d9e-6c9ba9bc1426	0	10	f	\N	\N
b8938006-d7a0-4087-b548-88473c230ae4	\N	auth-otp-form	master	5175eba9-6a66-4fa3-9d9e-6c9ba9bc1426	1	20	f	\N	\N
8ab812eb-ba2b-465a-9eb1-aa276a20714a	\N	direct-grant-validate-username	master	89e8f4ad-7681-41eb-bf3e-c781136c8060	0	10	f	\N	\N
97dd4767-d185-4200-ba39-78e7d6bfd142	\N	direct-grant-validate-password	master	89e8f4ad-7681-41eb-bf3e-c781136c8060	0	20	f	\N	\N
bc68877e-2db2-4d45-b338-3780cbfb6dbe	\N	direct-grant-validate-otp	master	89e8f4ad-7681-41eb-bf3e-c781136c8060	1	30	f	\N	\N
5c35b526-c3e6-4592-8e60-7d4fa5dc2c64	\N	registration-page-form	master	815317d3-6f71-4635-baa3-897884ecb30b	0	10	t	32b8fb30-dede-452c-9697-32caa6d0f684	\N
356ce5df-77e6-43a6-94bc-163ff3ea588b	\N	registration-user-creation	master	32b8fb30-dede-452c-9697-32caa6d0f684	0	20	f	\N	\N
6ec515fe-640a-4cc0-a458-0cfcb37f0655	\N	registration-profile-action	master	32b8fb30-dede-452c-9697-32caa6d0f684	0	40	f	\N	\N
eb5a5dc7-5a99-46ca-94d7-a3d2302ce33d	\N	registration-password-action	master	32b8fb30-dede-452c-9697-32caa6d0f684	0	50	f	\N	\N
fb38c8e3-4b6d-409f-92e8-4f0d185cc020	\N	registration-recaptcha-action	master	32b8fb30-dede-452c-9697-32caa6d0f684	3	60	f	\N	\N
9e9a76ca-0996-49ae-a080-35f3add9df4e	\N	reset-credentials-choose-user	master	0db8d7cc-6902-448c-9f99-03ce25ca6d37	0	10	f	\N	\N
76819a9f-b2c3-4913-a3fb-0cbf0817799e	\N	reset-credential-email	master	0db8d7cc-6902-448c-9f99-03ce25ca6d37	0	20	f	\N	\N
8d590900-6182-449d-8a0d-044edf061a45	\N	reset-password	master	0db8d7cc-6902-448c-9f99-03ce25ca6d37	0	30	f	\N	\N
a63b3afd-45ad-4ad8-ad06-ed8798e23dc2	\N	reset-otp	master	0db8d7cc-6902-448c-9f99-03ce25ca6d37	1	40	f	\N	\N
1fc6fb54-79c6-4f01-baa5-45101931bca5	\N	client-secret	master	f86ec19b-9b2d-4426-9ae3-ecde3c7722e6	2	10	f	\N	\N
cd4f44f8-2341-41a4-b3af-7d8f264d6d55	\N	client-jwt	master	f86ec19b-9b2d-4426-9ae3-ecde3c7722e6	2	20	f	\N	\N
233ccafa-3495-4cc5-bc81-619a89d5d9b2	\N	client-secret-jwt	master	f86ec19b-9b2d-4426-9ae3-ecde3c7722e6	2	30	f	\N	\N
50b3c2da-8253-4836-aed5-b54276a3662d	\N	idp-review-profile	master	8f0a300c-e174-4dec-af3c-463e1b324e58	0	10	f	\N	8bbb71a9-1cdc-472b-be9d-bb6fc6d7e936
a4dc142e-3ac1-4e6d-8edb-afda3a6c9c9b	\N	idp-create-user-if-unique	master	8f0a300c-e174-4dec-af3c-463e1b324e58	2	20	f	\N	f5adf073-9b9c-40c7-a4e1-0f84a1563ed2
1fd560e2-cfce-4c70-b02d-35021f112cf0	\N	\N	master	8f0a300c-e174-4dec-af3c-463e1b324e58	2	30	t	2cc8aa8d-ddd5-4ad4-94de-51a52cc80ca0	\N
52f58cd8-c1d2-4cf4-b00c-21fa0de6de80	\N	idp-confirm-link	master	2cc8aa8d-ddd5-4ad4-94de-51a52cc80ca0	0	10	f	\N	\N
ef8a9312-ad4d-4710-b3ff-1caa54f43bb9	\N	idp-email-verification	master	2cc8aa8d-ddd5-4ad4-94de-51a52cc80ca0	2	20	f	\N	\N
8c61a248-460f-4ae4-b0ad-5113c1c1f04a	\N	\N	master	2cc8aa8d-ddd5-4ad4-94de-51a52cc80ca0	2	30	t	e791a4c9-5518-460a-b165-7aa4829d85ba	\N
0b57a7b5-f892-40d7-8ac8-c26ea59b0044	\N	idp-username-password-form	master	e791a4c9-5518-460a-b165-7aa4829d85ba	0	10	f	\N	\N
63e09cba-8318-44e4-92d8-e869026c822c	\N	auth-otp-form	master	e791a4c9-5518-460a-b165-7aa4829d85ba	1	20	f	\N	\N
e0614ec8-728c-4c4d-8486-72e12025840d	\N	http-basic-authenticator	master	9408e355-e8b3-447a-a707-263bd81521f5	0	10	f	\N	\N
0386ef51-974e-4018-80d7-8915950eb0b2	\N	docker-http-basic-authenticator	master	4b83895d-3c3f-46d5-8f47-5f9be44477b8	0	10	f	\N	\N
377e4ceb-58ca-4d8b-88d8-e340e2dbce42	\N	idp-confirm-link	apicurio	df65ea2a-9437-4011-9c69-71cba81da364	0	10	f	\N	\N
f4e68e59-3fe5-4295-9456-4c38a697710d	\N	idp-email-verification	apicurio	df65ea2a-9437-4011-9c69-71cba81da364	2	20	f	\N	\N
3bb4e4be-93b7-4714-bb2f-62ad75aa45db	\N	\N	apicurio	df65ea2a-9437-4011-9c69-71cba81da364	2	30	t	a0911165-6eb1-42c3-beb6-7adb8cf7b9f1	\N
64d74d12-387f-4ec1-b124-dd18ead2c6ca	\N	idp-username-password-form	apicurio	a0911165-6eb1-42c3-beb6-7adb8cf7b9f1	0	10	f	\N	\N
faeb4506-4ba7-4171-8705-e7d65b4c87e2	\N	auth-otp-form	apicurio	a0911165-6eb1-42c3-beb6-7adb8cf7b9f1	1	20	f	\N	\N
a19b940b-94df-4da9-afc1-7b78796e8c45	\N	auth-cookie	apicurio	c460ce37-c909-4652-b384-b1db6946080d	2	10	f	\N	\N
2afbbb24-ec61-4f7c-b744-32d127f2cdcd	\N	auth-spnego	apicurio	c460ce37-c909-4652-b384-b1db6946080d	3	20	f	\N	\N
a31450e3-a9ec-4675-baec-be1d18384a92	\N	identity-provider-redirector	apicurio	c460ce37-c909-4652-b384-b1db6946080d	2	25	f	\N	\N
4f769f6c-02e5-4e7b-9817-18a7086854a8	\N	\N	apicurio	c460ce37-c909-4652-b384-b1db6946080d	2	30	t	fd040d82-128b-4b83-a9ad-a355f0d978a0	\N
cba29185-9226-4c26-8455-77d2e4befbfc	\N	client-secret	apicurio	04b52715-4a24-4f1e-87e3-057ad4411023	2	10	f	\N	\N
870c4f09-ef28-48e0-933a-1c886a0ef536	\N	client-jwt	apicurio	04b52715-4a24-4f1e-87e3-057ad4411023	2	20	f	\N	\N
99dfdd17-9b72-45fb-bc3d-32acb4c132a4	\N	direct-grant-validate-username	apicurio	57e0ec37-7e1b-4c6f-b04f-58c240b350fa	0	10	f	\N	\N
5516d003-4a31-4ad5-9ce7-2bad7b08142e	\N	direct-grant-validate-password	apicurio	57e0ec37-7e1b-4c6f-b04f-58c240b350fa	0	20	f	\N	\N
5133188d-a315-4d47-969f-4f41a702564e	\N	direct-grant-validate-otp	apicurio	57e0ec37-7e1b-4c6f-b04f-58c240b350fa	1	30	f	\N	\N
0d7285d9-2fb5-4f3d-8fa0-c7ef9f898670	\N	docker-http-basic-authenticator	apicurio	91423aca-8bc1-4e10-9e4c-f7ab44db13e2	0	10	f	\N	\N
3dd9e178-9d5a-405d-8327-905b2640020b	\N	idp-review-profile	apicurio	015ed7a5-12db-4292-8e00-fc9ae16d3a51	0	10	f	\N	f935b554-2296-4fff-acb1-ecc5dd52dae4
e7c13de7-25eb-43ce-bd82-6b61cb7151fd	\N	idp-create-user-if-unique	apicurio	015ed7a5-12db-4292-8e00-fc9ae16d3a51	2	20	f	\N	8dd21117-505d-4c2d-a3c2-0cd472d47757
a4cf16a1-2381-463e-9636-36024411a44d	\N	\N	apicurio	015ed7a5-12db-4292-8e00-fc9ae16d3a51	2	30	t	df65ea2a-9437-4011-9c69-71cba81da364	\N
79613904-ce41-46d9-a150-fe2f4dfe9fd7	\N	auth-username-password-form	apicurio	fd040d82-128b-4b83-a9ad-a355f0d978a0	0	10	f	\N	\N
c81d0d93-1d6b-450d-9c9b-451230e143b5	\N	auth-otp-form	apicurio	fd040d82-128b-4b83-a9ad-a355f0d978a0	1	20	f	\N	\N
8a396f3a-14f8-4e25-8d3c-aeeb3cad892c	\N	registration-page-form	apicurio	8ce2b483-3dd8-428f-957b-42fd343d7350	0	10	t	57e19811-e120-4a33-a603-89a966b6a53d	\N
1e00cd1d-b242-452b-ae66-1eb6b57b6ad8	\N	registration-user-creation	apicurio	57e19811-e120-4a33-a603-89a966b6a53d	0	20	f	\N	\N
d951b764-88e1-4268-aeae-68eda4fbe2ae	\N	registration-profile-action	apicurio	57e19811-e120-4a33-a603-89a966b6a53d	0	40	f	\N	\N
06849325-9dc5-41ad-b09d-ec3463f2d764	\N	registration-password-action	apicurio	57e19811-e120-4a33-a603-89a966b6a53d	0	50	f	\N	\N
21eba0a5-1f45-4d0a-9825-b1059e84919f	\N	registration-recaptcha-action	apicurio	57e19811-e120-4a33-a603-89a966b6a53d	3	60	f	\N	\N
429508e5-3f63-47d8-8cb8-751f5a7453a0	\N	reset-credentials-choose-user	apicurio	3b6b9062-33d4-40f2-8edd-8aae8dc5fbcc	0	10	f	\N	\N
3a4f01e9-da4c-494d-a31c-8ab88a58a22e	\N	reset-credential-email	apicurio	3b6b9062-33d4-40f2-8edd-8aae8dc5fbcc	0	20	f	\N	\N
5e4852ba-8e66-425d-8c32-f8d5a0f27e81	\N	reset-password	apicurio	3b6b9062-33d4-40f2-8edd-8aae8dc5fbcc	0	30	f	\N	\N
b3c40da3-cf49-4974-af2f-d161de29eded	\N	reset-otp	apicurio	3b6b9062-33d4-40f2-8edd-8aae8dc5fbcc	1	40	f	\N	\N
f2750773-d639-40de-895f-9be5ccf920a0	\N	http-basic-authenticator	apicurio	fd508211-99f1-4e04-bfda-088df429f3f0	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
14fc0101-93a1-4fb8-907a-baf3e1f2bc67	browser	browser based authentication	master	basic-flow	t	t
5175eba9-6a66-4fa3-9d9e-6c9ba9bc1426	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
89e8f4ad-7681-41eb-bf3e-c781136c8060	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
815317d3-6f71-4635-baa3-897884ecb30b	registration	registration flow	master	basic-flow	t	t
32b8fb30-dede-452c-9697-32caa6d0f684	registration form	registration form	master	form-flow	f	t
0db8d7cc-6902-448c-9f99-03ce25ca6d37	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
f86ec19b-9b2d-4426-9ae3-ecde3c7722e6	clients	Base authentication for clients	master	client-flow	t	t
8f0a300c-e174-4dec-af3c-463e1b324e58	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
2cc8aa8d-ddd5-4ad4-94de-51a52cc80ca0	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
e791a4c9-5518-460a-b165-7aa4829d85ba	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
9408e355-e8b3-447a-a707-263bd81521f5	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
4b83895d-3c3f-46d5-8f47-5f9be44477b8	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
df65ea2a-9437-4011-9c69-71cba81da364	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	apicurio	basic-flow	f	t
a0911165-6eb1-42c3-beb6-7adb8cf7b9f1	Verify Existing Account by Re-authentication	Reauthentication of existing account	apicurio	basic-flow	f	t
c460ce37-c909-4652-b384-b1db6946080d	browser	browser based authentication	apicurio	basic-flow	t	t
04b52715-4a24-4f1e-87e3-057ad4411023	clients	Base authentication for clients	apicurio	client-flow	t	t
57e0ec37-7e1b-4c6f-b04f-58c240b350fa	direct grant	OpenID Connect Resource Owner Grant	apicurio	basic-flow	t	t
91423aca-8bc1-4e10-9e4c-f7ab44db13e2	docker auth	Used by Docker clients to authenticate against the IDP	apicurio	basic-flow	t	t
015ed7a5-12db-4292-8e00-fc9ae16d3a51	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	apicurio	basic-flow	t	t
fd040d82-128b-4b83-a9ad-a355f0d978a0	forms	Username, password, otp and other auth forms.	apicurio	basic-flow	f	t
8ce2b483-3dd8-428f-957b-42fd343d7350	registration	registration flow	apicurio	basic-flow	t	t
57e19811-e120-4a33-a603-89a966b6a53d	registration form	registration form	apicurio	form-flow	f	t
3b6b9062-33d4-40f2-8edd-8aae8dc5fbcc	reset credentials	Reset credentials for a user if they forgot their password or something	apicurio	basic-flow	t	t
fd508211-99f1-4e04-bfda-088df429f3f0	saml ecp	SAML ECP Profile Authentication Flow	apicurio	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY authenticator_config (id, alias, realm_id) FROM stdin;
8bbb71a9-1cdc-472b-be9d-bb6fc6d7e936	review profile config	master
f5adf073-9b9c-40c7-a4e1-0f84a1563ed2	create unique user config	master
8dd21117-505d-4c2d-a3c2-0cd472d47757	create unique user config	apicurio
f935b554-2296-4fff-acb1-ecc5dd52dae4	review profile config	apicurio
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY authenticator_config_entry (authenticator_id, value, name) FROM stdin;
8bbb71a9-1cdc-472b-be9d-bb6fc6d7e936	missing	update.profile.on.first.login
f5adf073-9b9c-40c7-a4e1-0f84a1563ed2	false	require.password.update.after.registration
8dd21117-505d-4c2d-a3c2-0cd472d47757	false	require.password.update.after.registration
f935b554-2296-4fff-acb1-ecc5dd52dae4	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled) FROM stdin;
8702814b-4ddc-4ed2-8f07-9185873cc2df	t	t	master-realm	0	f	1b5bace1-dd79-4703-8f7f-7047720870e0	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f
f036cd86-f38d-49d0-83a7-e1babea17489	t	f	account	0	f	c118acf2-7802-40f3-afa3-d25be02ac4e7	/auth/realms/master/account	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	\N	\N	\N	t	f	f
086db8dd-b7d8-4f56-84bf-7547f233c86d	t	f	broker	0	f	f338325f-15a3-41a4-8648-590835ac3e81	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
c15085ea-9ade-4e9e-b867-cc94574dfda1	t	f	security-admin-console	0	t	c09156ee-3bba-4fc0-a206-78dc4fdc68cb	/auth/admin/master/console/index.html	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	\N	\N	\N	t	f	f
ec1a3547-c74d-4d4e-9d2b-88554766ab10	t	f	admin-cli	0	t	13e0d9b3-aebf-4ef7-b221-7af9709268d6	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	t	apicurio-realm	0	f	9968c815-7e11-4b06-a1ec-736400d900f9	\N	t	\N	f	master	\N	0	f	f	apicurio Realm	f	client-secret	\N	\N	\N	t	f	f
d00c75ee-f771-41d4-9374-02ee2b60119f	t	t	apicurio-api	0	f	**********	\N	t	\N	f	apicurio	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	t	f	security-admin-console	0	t	**********	/auth/admin/apicurio/console/index.html	f	\N	f	apicurio	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	\N	\N	\N	t	f	f
d2d71b30-cc35-4911-b89b-8ed17811b0c5	t	f	admin-cli	0	t	**********	\N	f	\N	f	apicurio	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	t	f	broker	0	f	**********	\N	f	\N	f	apicurio	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
3cc45054-7d22-4926-aa41-de29712997f3	t	f	realm-management	0	f	**********	\N	t	\N	f	apicurio	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f
672c1b68-be12-464a-a904-86a7c352d1b9	t	f	account	0	f	**********	/auth/realms/apicurio/account	f	\N	f	apicurio	openid-connect	0	f	f	${client_account}	f	client-secret	\N	\N	\N	t	f	f
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	t	t	apicurio-studio	0	t	**********	https://apicurio-studio.apps.dev.openshift.redhatkeynote.com	f	\N	f	apicurio	openid-connect	-1	f	f	\N	f	client-secret	https://apicurio-studio.apps.dev.openshift.redhatkeynote.com	\N	\N	t	f	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_attributes (client_id, value, name) FROM stdin;
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.assertion.signature
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.force.post.binding
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.multivalued.roles
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.encrypt
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml_force_name_id_format
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.client.signature
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.authnstatement
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.server.signature
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.server.signature.keyinfo.ext
d00c75ee-f771-41d4-9374-02ee2b60119f	false	saml.onetimeuse.condition
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.assertion.signature
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.force.post.binding
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.multivalued.roles
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.encrypt
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml_force_name_id_format
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.client.signature
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.authnstatement
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.server.signature
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.server.signature.keyinfo.ext
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	false	saml.onetimeuse.condition
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_default_roles (client_id, role_id) FROM stdin;
f036cd86-f38d-49d0-83a7-e1babea17489	9d79a9a2-e942-4332-ba3c-c9d9a2db521d
f036cd86-f38d-49d0-83a7-e1babea17489	45382874-db6b-4c3c-97c6-480f68745f7d
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	6d5d5080-1541-4acb-8d7f-3fc93f723f56
672c1b68-be12-464a-a904-86a7c352d1b9	078e7991-5dd9-43e4-af4c-c5aa2a92e21c
672c1b68-be12-464a-a904-86a7c352d1b9	976f7bf4-5230-45a0-9e20-d69f9beb6c3e
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_scope (id, name, realm_id, description, protocol) FROM stdin;
36285060-103f-4503-8fb7-3fa11fcbf595	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
c78f16fe-fc10-450b-84e6-326f1e16ef5a	role_list	master	SAML role list	saml
2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	profile	master	OpenID Connect built-in scope: profile	openid-connect
06a182f7-5d41-4292-a816-9265e6403545	email	master	OpenID Connect built-in scope: email	openid-connect
dc579de7-aff9-477f-a915-8870ed197ded	address	master	OpenID Connect built-in scope: address	openid-connect
710b0144-c205-4973-83c8-b55c7c27071b	phone	master	OpenID Connect built-in scope: phone	openid-connect
202bccce-83ad-4b51-b1cc-03b30767615e	offline_access	apicurio	OpenID Connect built-in scope: offline_access	openid-connect
8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	role_list	apicurio	SAML role list	saml
a79c4431-e328-4cf2-9d2f-64438ca49cb9	profile	apicurio	OpenID Connect built-in scope: profile	openid-connect
9e334551-c1ef-4128-89a3-26e26725ac27	email	apicurio	OpenID Connect built-in scope: email	openid-connect
5eff62af-767d-46dd-bf43-5394f39aa356	address	apicurio	OpenID Connect built-in scope: address	openid-connect
a638cf1e-d35d-402b-baa2-0ddbb602bf33	phone	apicurio	OpenID Connect built-in scope: phone	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_scope_attributes (scope_id, value, name) FROM stdin;
36285060-103f-4503-8fb7-3fa11fcbf595	${offlineAccessScopeConsentText}	consent.screen.text
36285060-103f-4503-8fb7-3fa11fcbf595	true	display.on.consent.screen
c78f16fe-fc10-450b-84e6-326f1e16ef5a	${samlRoleListScopeConsentText}	consent.screen.text
c78f16fe-fc10-450b-84e6-326f1e16ef5a	true	display.on.consent.screen
2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	${profileScopeConsentText}	consent.screen.text
2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	true	display.on.consent.screen
06a182f7-5d41-4292-a816-9265e6403545	${emailScopeConsentText}	consent.screen.text
06a182f7-5d41-4292-a816-9265e6403545	true	display.on.consent.screen
dc579de7-aff9-477f-a915-8870ed197ded	${addressScopeConsentText}	consent.screen.text
dc579de7-aff9-477f-a915-8870ed197ded	true	display.on.consent.screen
710b0144-c205-4973-83c8-b55c7c27071b	${phoneScopeConsentText}	consent.screen.text
710b0144-c205-4973-83c8-b55c7c27071b	true	display.on.consent.screen
202bccce-83ad-4b51-b1cc-03b30767615e	${offlineAccessScopeConsentText}	consent.screen.text
202bccce-83ad-4b51-b1cc-03b30767615e	true	display.on.consent.screen
8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	${samlRoleListScopeConsentText}	consent.screen.text
8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	true	display.on.consent.screen
a79c4431-e328-4cf2-9d2f-64438ca49cb9	${profileScopeConsentText}	consent.screen.text
a79c4431-e328-4cf2-9d2f-64438ca49cb9	true	display.on.consent.screen
9e334551-c1ef-4128-89a3-26e26725ac27	${emailScopeConsentText}	consent.screen.text
9e334551-c1ef-4128-89a3-26e26725ac27	true	display.on.consent.screen
5eff62af-767d-46dd-bf43-5394f39aa356	${addressScopeConsentText}	consent.screen.text
5eff62af-767d-46dd-bf43-5394f39aa356	true	display.on.consent.screen
a638cf1e-d35d-402b-baa2-0ddbb602bf33	${phoneScopeConsentText}	consent.screen.text
a638cf1e-d35d-402b-baa2-0ddbb602bf33	true	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_scope_client (client_id, scope_id, default_scope) FROM stdin;
f036cd86-f38d-49d0-83a7-e1babea17489	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
ec1a3547-c74d-4d4e-9d2b-88554766ab10	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
086db8dd-b7d8-4f56-84bf-7547f233c86d	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
8702814b-4ddc-4ed2-8f07-9185873cc2df	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
c15085ea-9ade-4e9e-b867-cc94574dfda1	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
f036cd86-f38d-49d0-83a7-e1babea17489	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
f036cd86-f38d-49d0-83a7-e1babea17489	06a182f7-5d41-4292-a816-9265e6403545	t
f036cd86-f38d-49d0-83a7-e1babea17489	36285060-103f-4503-8fb7-3fa11fcbf595	f
f036cd86-f38d-49d0-83a7-e1babea17489	dc579de7-aff9-477f-a915-8870ed197ded	f
f036cd86-f38d-49d0-83a7-e1babea17489	710b0144-c205-4973-83c8-b55c7c27071b	f
ec1a3547-c74d-4d4e-9d2b-88554766ab10	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
ec1a3547-c74d-4d4e-9d2b-88554766ab10	06a182f7-5d41-4292-a816-9265e6403545	t
ec1a3547-c74d-4d4e-9d2b-88554766ab10	36285060-103f-4503-8fb7-3fa11fcbf595	f
ec1a3547-c74d-4d4e-9d2b-88554766ab10	dc579de7-aff9-477f-a915-8870ed197ded	f
ec1a3547-c74d-4d4e-9d2b-88554766ab10	710b0144-c205-4973-83c8-b55c7c27071b	f
086db8dd-b7d8-4f56-84bf-7547f233c86d	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
086db8dd-b7d8-4f56-84bf-7547f233c86d	06a182f7-5d41-4292-a816-9265e6403545	t
086db8dd-b7d8-4f56-84bf-7547f233c86d	36285060-103f-4503-8fb7-3fa11fcbf595	f
086db8dd-b7d8-4f56-84bf-7547f233c86d	dc579de7-aff9-477f-a915-8870ed197ded	f
086db8dd-b7d8-4f56-84bf-7547f233c86d	710b0144-c205-4973-83c8-b55c7c27071b	f
8702814b-4ddc-4ed2-8f07-9185873cc2df	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
8702814b-4ddc-4ed2-8f07-9185873cc2df	06a182f7-5d41-4292-a816-9265e6403545	t
8702814b-4ddc-4ed2-8f07-9185873cc2df	36285060-103f-4503-8fb7-3fa11fcbf595	f
8702814b-4ddc-4ed2-8f07-9185873cc2df	dc579de7-aff9-477f-a915-8870ed197ded	f
8702814b-4ddc-4ed2-8f07-9185873cc2df	710b0144-c205-4973-83c8-b55c7c27071b	f
c15085ea-9ade-4e9e-b867-cc94574dfda1	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
c15085ea-9ade-4e9e-b867-cc94574dfda1	06a182f7-5d41-4292-a816-9265e6403545	t
c15085ea-9ade-4e9e-b867-cc94574dfda1	36285060-103f-4503-8fb7-3fa11fcbf595	f
c15085ea-9ade-4e9e-b867-cc94574dfda1	dc579de7-aff9-477f-a915-8870ed197ded	f
c15085ea-9ade-4e9e-b867-cc94574dfda1	710b0144-c205-4973-83c8-b55c7c27071b	f
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	06a182f7-5d41-4292-a816-9265e6403545	t
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	36285060-103f-4503-8fb7-3fa11fcbf595	f
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	dc579de7-aff9-477f-a915-8870ed197ded	f
94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	710b0144-c205-4973-83c8-b55c7c27071b	f
d00c75ee-f771-41d4-9374-02ee2b60119f	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
d00c75ee-f771-41d4-9374-02ee2b60119f	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
d00c75ee-f771-41d4-9374-02ee2b60119f	9e334551-c1ef-4128-89a3-26e26725ac27	t
d00c75ee-f771-41d4-9374-02ee2b60119f	202bccce-83ad-4b51-b1cc-03b30767615e	f
d00c75ee-f771-41d4-9374-02ee2b60119f	5eff62af-767d-46dd-bf43-5394f39aa356	f
d00c75ee-f771-41d4-9374-02ee2b60119f	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	9e334551-c1ef-4128-89a3-26e26725ac27	t
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	202bccce-83ad-4b51-b1cc-03b30767615e	f
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	5eff62af-767d-46dd-bf43-5394f39aa356	f
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
d2d71b30-cc35-4911-b89b-8ed17811b0c5	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
d2d71b30-cc35-4911-b89b-8ed17811b0c5	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
d2d71b30-cc35-4911-b89b-8ed17811b0c5	9e334551-c1ef-4128-89a3-26e26725ac27	t
d2d71b30-cc35-4911-b89b-8ed17811b0c5	202bccce-83ad-4b51-b1cc-03b30767615e	f
d2d71b30-cc35-4911-b89b-8ed17811b0c5	5eff62af-767d-46dd-bf43-5394f39aa356	f
d2d71b30-cc35-4911-b89b-8ed17811b0c5	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	9e334551-c1ef-4128-89a3-26e26725ac27	t
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	202bccce-83ad-4b51-b1cc-03b30767615e	f
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	5eff62af-767d-46dd-bf43-5394f39aa356	f
b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
3cc45054-7d22-4926-aa41-de29712997f3	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
3cc45054-7d22-4926-aa41-de29712997f3	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
3cc45054-7d22-4926-aa41-de29712997f3	9e334551-c1ef-4128-89a3-26e26725ac27	t
3cc45054-7d22-4926-aa41-de29712997f3	202bccce-83ad-4b51-b1cc-03b30767615e	f
3cc45054-7d22-4926-aa41-de29712997f3	5eff62af-767d-46dd-bf43-5394f39aa356	f
3cc45054-7d22-4926-aa41-de29712997f3	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
672c1b68-be12-464a-a904-86a7c352d1b9	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
672c1b68-be12-464a-a904-86a7c352d1b9	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
672c1b68-be12-464a-a904-86a7c352d1b9	9e334551-c1ef-4128-89a3-26e26725ac27	t
672c1b68-be12-464a-a904-86a7c352d1b9	202bccce-83ad-4b51-b1cc-03b30767615e	f
672c1b68-be12-464a-a904-86a7c352d1b9	5eff62af-767d-46dd-bf43-5394f39aa356	f
672c1b68-be12-464a-a904-86a7c352d1b9	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	9e334551-c1ef-4128-89a3-26e26725ac27	t
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	202bccce-83ad-4b51-b1cc-03b30767615e	f
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	5eff62af-767d-46dd-bf43-5394f39aa356	f
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_scope_role_mapping (scope_id, role_id) FROM stdin;
36285060-103f-4503-8fb7-3fa11fcbf595	2b2f7770-e203-4e18-bdf6-3485f41362e3
202bccce-83ad-4b51-b1cc-03b30767615e	4b82c838-4ba2-4263-9147-873f69f1495a
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: codegen; Type: TABLE DATA; Schema: public; Owner: -
--

COPY codegen (id, created_by, created_on, modified_by, modified_on, design_id, ptype, attributes) FROM stdin;
1	stuart.w.douglas@gmail.com	2019-04-04 05:48:08.961	stuart.w.douglas@gmail.com	2019-04-04 05:49:50.192	1	thorntail	javaPackage=Y29tLnJlZGhhdC5kZW1vLmFwaQ==\npublish-branch=bWFzdGVy\ngroupId=Y29tLnJlZGhhdC5kZW1v\npublish-org=cmhkZW1v\npublish-type=R2l0SHVi\npullRequest-url=aHR0cHM6Ly9naXRodWIuY29tL3JoZGVtby8yMDE5LWRlbW80LW1hY2hpbmUtaGlzdG9yeS9wdWxsLzM5\npublish-repo=MjAxOS1kZW1vNC1tYWNoaW5lLWhpc3Rvcnk=\nartifactId=bWFjaGluZS1oaXN0b3J5\nlocation=c291cmNlQ29udHJvbA==\npublish-commitMessage=SW1wb3J0IEFQSQ==\nupdate-only=dHJ1ZQ==\npublish-location=L21hY2hpbmUtaGlzdG9yeQ==\n
\.


--
-- Name: codegen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('codegen_id_seq', 1, true);


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
4e5504e0-c5f9-40b7-a29b-a9a378998b99	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
c558d6c1-821b-4375-b6b5-c4c25337b697	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
11361699-3ccd-483a-b9b7-5e41c2ec108a	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
0ab6281f-ddb5-403e-a9d6-cbeb2317337e	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
e3a87a15-a977-404c-bae3-aaa03282d5aa	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d8aa79ae-cb84-44ec-8319-28b82930563f	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5f48b82d-6aea-4b20-93ab-c9d035e303d6	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
d12c6eb4-14a5-4c3d-b496-724ee722338a	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
6b7439b9-a591-42f2-ba1c-57218e940744	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
2bb2d6a1-f7e0-4b38-985b-e05edd973db9	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
2c2421fe-ddf0-452c-ac1b-429a5a279b81	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
fef3ce04-610b-4133-8348-a83d7b8678cb	Trusted Hosts	apicurio	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	anonymous
9eab2a5c-edf0-4311-9852-2d572efcf19c	Max Clients Limit	apicurio	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	anonymous
4b4a3beb-5fe7-4719-98d9-6bb21cac455d	Consent Required	apicurio	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	anonymous
1d5feae9-2d0e-4d96-b6b7-c593ef91f6fe	Allowed Client Templates	apicurio	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	authenticated
c86dbe48-139f-430a-b59c-995f55699646	Full Scope Disabled	apicurio	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	anonymous
45c06394-acdb-45c6-b982-2b72bb4de799	Allowed Protocol Mapper Types	apicurio	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	anonymous
8f92b4cb-dedc-4051-8696-fe9c275387ff	Allowed Protocol Mapper Types	apicurio	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	authenticated
bf534cae-067d-4316-b5b7-4aeb0947d651	Allowed Client Templates	apicurio	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	apicurio	anonymous
d7f31252-c97f-4458-a2d9-e72ba81d5b99	rsa-generated	apicurio	rsa-generated	org.keycloak.keys.KeyProvider	apicurio	\N
faf59f09-a28e-4966-8f10-4c26cc919d36	hmac-generated	apicurio	hmac-generated	org.keycloak.keys.KeyProvider	apicurio	\N
1c64dc8d-3c68-4ce9-ac59-9b477637b198	aes-generated	apicurio	aes-generated	org.keycloak.keys.KeyProvider	apicurio	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY component_config (id, component_id, name, value) FROM stdin;
be7ea2b6-f248-4072-a90d-81df3993d77e	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
517610b5-6bc5-4fd2-bc06-8bad4dfd8da3	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	saml-user-attribute-mapper
f168ba02-f903-441d-9e42-bbe694fba88f	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	oidc-address-mapper
42d1827c-e5eb-49e5-8bd4-a0c3b71be1d8	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	saml-role-list-mapper
638eea2d-3f96-41d2-99dc-83d71118c812	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	saml-user-property-mapper
dd86c74a-3549-4364-ae83-be74302e43da	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	oidc-full-name-mapper
663ceec6-05a8-43e0-824f-f3ff1c69aa1f	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1b8b38d5-4a81-40e2-90f1-32b79b424d4e	e3a87a15-a977-404c-bae3-aaa03282d5aa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
770dfb6b-876a-431c-a9e5-cb7fc7465fa0	0ab6281f-ddb5-403e-a9d6-cbeb2317337e	max-clients	200
99294424-d5d1-444f-8035-86ee31cb099a	d8aa79ae-cb84-44ec-8319-28b82930563f	allow-default-scopes	true
0ff63382-8c92-4314-9583-8ffc53c462ae	d12c6eb4-14a5-4c3d-b496-724ee722338a	allow-default-scopes	true
e9b0f0c4-dab8-41c3-82ba-228f04bdb9a5	4e5504e0-c5f9-40b7-a29b-a9a378998b99	client-uris-must-match	true
34d4a663-9715-4dfb-a805-16a97481b847	4e5504e0-c5f9-40b7-a29b-a9a378998b99	host-sending-registration-request-must-match	true
ad012215-edd1-4560-8822-a8a84b400517	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	saml-role-list-mapper
62f6b130-a062-4748-b4ec-9325fd32606b	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
03c3ad65-947c-4350-8f62-759322023299	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	oidc-full-name-mapper
e0206397-480c-4783-aac0-419a3ed00c7a	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	oidc-address-mapper
03efe669-7605-42cd-bcad-3bd42019bb50	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	saml-user-property-mapper
4a51622a-6b47-4fb2-9da7-72644f9d51a9	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4a49cbde-63b3-4958-a3db-8967db9ca764	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
cc463e39-4c0a-4b42-b52d-cd1792d52784	5f48b82d-6aea-4b20-93ab-c9d035e303d6	allowed-protocol-mapper-types	saml-user-attribute-mapper
abf6ed2b-5737-49a6-b5ab-d54088732d31	6b7439b9-a591-42f2-ba1c-57218e940744	privateKey	MIIEpAIBAAKCAQEAiSkS13caO9t3L5vzczcfajeZcI1mhS9St/6Adkiavb4lZc+MBxN48FKcETWl+U7PmHdi29LvJOfPF8ACJrDibVU0y3iFvQedlPbL1nbzBmTlCUG5HbSLzmEaWpG+L1ueqftkHzFfFe5s4KkfNjPMxlC6QRGf69AJKkCzEOTOTFs8QHUKczI0UkNP4ndN0PZFPiYCEcZ41pCOUKpaiTJte5q5raizC7V21qPcfnD5yIdN/qTaYITP4kOjOtYy29HVHEEn1lW083X4Hzr03OMEUFf2xC7enmtqMwadZxdI5bRJtpBjiP/9swZScawGcZ2GapeYUAzEvwMY4dzWXkauHwIDAQABAoIBAE3eCZpVPYl54MIgkSd5xdXxVqT1QZye7yER1TBRq7fIuUaBe4eQ4HnfDEcg4+cTfPub233c1HNpPsLG+PGqPgG/+8b/1z0nk6i8K6DHytR4dya4LzXUCALUUbfVQdl09DCgTYj/6HF0+E7a9KM66Sg1MGg8b0PayTk5ne8bVps13iUNzq8oN2g7FDOjKgcVe+JQtOl0ejCuIvVdj8frmKyewrjllSIC0dPsKYPEqe5OOwbUw4j0vRqUHoghkOpJUwLaVkfChIJ9fYpNPUkwfPR7Ch/HF4ks+EplBsAy4zkQAMqBkVkt1UsW3BsUHlNaixt1cSSj/L6RFSUtOrxHdkECgYEA693oaUvSTZ1HSX5weq9G/erbq6zRG+w822gGFIQ1pJAq/SYVx4RxotSCEi5272E1I7g6IisQBElwgPtxUFS/+t5GmmXG1OTDz2tM7sZgW6lmjSmheeNS6hK/HCCuMHe6JILNjz6HKhce2KUWssJCN+Q7M699d+dVhH1mw7qh4NECgYEAlN5DVsuYRuwfUcwbbXZDttkBDO+UVcPqySoBAKOTd1PxbT1ik5/ezuJQ7SR9ctg3hyt1x/QdtsDgD8rH48DdfvLt9APhWCiNovH5SIYvKyEdfEyyXGA9mrscjF818u48royn9GB+3VFta1YnFwBrBNVfwqu54bGdnl4WUqVj2+8CgYEAlqK3bqAU5KrAv2g377KHdV0MBD0vo1ShnUJ3N50kIUBNpDUxjaXBaUus8m2oWcNMS865md7EsOgyKL3tJW+q2E4i6zJ65LZhc9PEY25gVcn/i8H9tbl/16w3T4BzntKoF+9N1uEJM9FmSthMgcfcwJNLV/wI9o3QqPfprLFB9zECgYB3AAUMSMt9RhrzJBl4suUGMQmp8Ym91VLFY5JRlHC5Hp0LGdrG7zEIZ9kQ9+5f837PymnoYLev8xYpCYwn/3APntmgCcoE0sYFzy/aTYk/DMWpKxYYycX0/kWf4Cwb+V0AmudXbht7hy/UcZXlySvDPV3DG8sHIxhAFC37+sGMeQKBgQDXLHGMPLDm/ed3FSqZl/xp3O5ZTaDEKz40qgnkOvin6tgNw4R2TuX8lmy/ByUQbsr0WopMNQah81QsoOp4BOhhVREhmssbwYlfZ/wQPcYQPMpxyJqwtXrOiRFk4Ef2vWbdoCTiafWBYeOX5CO91jwyFmGgjWvls6foh0zU8X0Mcw==
0fae01b8-e536-4534-a6ae-99bc096369ee	6b7439b9-a591-42f2-ba1c-57218e940744	certificate	MIICmzCCAYMCBgFp5tcmMTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMTkwNDA0MDUzMjMzWhcNMjkwNDA0MDUzNDEzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCJKRLXdxo723cvm/NzNx9qN5lwjWaFL1K3/oB2SJq9viVlz4wHE3jwUpwRNaX5Ts+Yd2Lb0u8k588XwAImsOJtVTTLeIW9B52U9svWdvMGZOUJQbkdtIvOYRpakb4vW56p+2QfMV8V7mzgqR82M8zGULpBEZ/r0AkqQLMQ5M5MWzxAdQpzMjRSQ0/id03Q9kU+JgIRxnjWkI5QqlqJMm17mrmtqLMLtXbWo9x+cPnIh03+pNpghM/iQ6M61jLb0dUcQSfWVbTzdfgfOvTc4wRQV/bELt6ea2ozBp1nF0jltEm2kGOI//2zBlJxrAZxnYZql5hQDMS/Axjh3NZeRq4fAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEADr30Gn7hK3dA/gtH2NrFlIkE0LPuNM1zI9ajaDBkXTPPgVgjrxkYFO/Bl9sB8MQZROHMUTQySn88poXrkgMHm30OixIAOkp8jtarTcTMnC4e81rU4J4UY2y8yalulodz39XGdM4Bc+ar0JyAXxVed7x5zoAI+QCibGljNpHAMcbISHeyhkJtRw8vSCAj0yQW536C2S1aJbuGvVtkhGY/I6QiShkz7axnGDDn6hctLld0oZgzA3L/qYNyM9q/cNCov7CdDI0MDJgs64fhZjkrhw028WnLXBgqxZwSMGhMCMFg4F/cm1Iro1RF5dCOnrlG3k51DKHpmKoYCWEdticM=
beac5262-baa2-492b-9979-4d1137a864af	6b7439b9-a591-42f2-ba1c-57218e940744	priority	100
9e6f8402-6ce5-41ff-a28a-d0f82b44cf00	2c2421fe-ddf0-452c-ac1b-429a5a279b81	secret	gLZLKrTbrXTFFeDRM4I2KQ
1b909812-98eb-41f0-b714-1ed30d7e35d1	2c2421fe-ddf0-452c-ac1b-429a5a279b81	kid	70751cf8-4a46-4147-b020-23b6b4b5e761
6f4674c7-6763-4e4f-a875-86f0fd536c21	2c2421fe-ddf0-452c-ac1b-429a5a279b81	priority	100
01a62800-f3e3-4222-9733-4219e8f2d23a	2bb2d6a1-f7e0-4b38-985b-e05edd973db9	priority	100
31fc52ac-9253-4a07-a3bf-c4d79fd102c0	2bb2d6a1-f7e0-4b38-985b-e05edd973db9	secret	RfyyUZxfMYDwThckN0ri8UQ0QL3VrpcwS21hRp6kdRY
389ced56-836b-4159-b358-652b9eb92b88	2bb2d6a1-f7e0-4b38-985b-e05edd973db9	kid	6944c98f-3d2e-4325-8d91-2de99be3f0af
3db2ef3e-c931-4342-96c9-9e48efd7a715	fef3ce04-610b-4133-8348-a83d7b8678cb	host-sending-registration-request-must-match	true
bbd550f6-ba4d-466f-9c2d-30e3d47a9243	fef3ce04-610b-4133-8348-a83d7b8678cb	client-uris-must-match	true
be942b1c-4b83-4ad0-8843-7871f1c479bb	9eab2a5c-edf0-4311-9852-2d572efcf19c	max-clients	200
ab088cf1-8856-4c52-b6be-357b513ea183	45c06394-acdb-45c6-b982-2b72bb4de799	consent-required-for-all-mappers	true
14673f4e-0b11-4e5b-860f-c7925f5af222	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
fe607cf5-edf0-42e3-808a-2c7140a01e80	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
52773bba-69fe-4cb5-8f3e-14c4a062e715	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	saml-user-attribute-mapper
33e80bb7-94d0-49c5-a862-36e806c3e2e2	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	saml-user-property-mapper
042e6b0b-4438-46e1-a0bb-d943576e5f50	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	oidc-full-name-mapper
83ae9ba5-0159-4832-b3a6-161b796dcddb	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f3ee1616-c62e-4bcf-b817-aa29d13ab2ab	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	saml-role-list-mapper
5be88fb6-4ec7-4dae-a94a-b7a763eb0c21	45c06394-acdb-45c6-b982-2b72bb4de799	allowed-protocol-mapper-types	oidc-address-mapper
819e63c8-96af-4c97-b224-085f9897d427	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	oidc-address-mapper
b370bc8c-2c35-41da-ad42-b5f6ea406f8c	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	oidc-full-name-mapper
9ff42b58-b6f0-4012-b48f-067a8f317ba5	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
cc499915-fbb9-4876-ba68-f034b51251dd	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	saml-user-attribute-mapper
aa1747af-6356-4550-b427-04dc417b7ead	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	saml-role-list-mapper
efd91125-1b73-45b4-8993-bb0c429d14f9	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d5e84f99-008a-4516-8b9f-30fdfc43d8f0	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
20c698d6-8a7b-42da-b070-b6191b523ba3	8f92b4cb-dedc-4051-8696-fe9c275387ff	consent-required-for-all-mappers	true
f509b3fb-eee9-4be9-b9ee-10d577bedbb6	8f92b4cb-dedc-4051-8696-fe9c275387ff	allowed-protocol-mapper-types	saml-user-property-mapper
7ce0ff9a-2a1f-45b2-9a0c-714a172f623e	d7f31252-c97f-4458-a2d9-e72ba81d5b99	priority	100
04d252bc-7fa9-4473-91b5-11b69542e76c	d7f31252-c97f-4458-a2d9-e72ba81d5b99	privateKey	MIIEpgIBAAKCAQEA6EOEIxBjPb0/2En4WRwK2Cdz6EHyuGk+zeZOd0RcXnjK6Qf4qT7PHJ2rc49/aGEgKZyhHmP1C5s/P/qMXKsRVP8NziBt8y98Bvb+460iuS202fiSr35HDhqFZBX5J1G0R2rHkaVjInPvRccUjuS9yJOPCi8igucea1dCeudlAKp51FvM43oW9nz63qKwo8C3YylRy+wcum6CYyDTYT/QIBbQrcGJUw4DtFYpoA/fuVzcPvT0Dn0gWRnqrmmAogO3U/VxCdh6BkkVhijEClxPYE5syH/6+ePEUT/Pp4owLi00ak+3S2uNGxVjOhLbkjQWVLFrFvccZR80Av8dmtfywwIDAQABAoIBAQDRTj6epp74PTpyvD4cd2PiZLNUA1IrE1TwkfH2Etm2nN4mX/Oa+SoFXKTsD82+D4C/XxHm5CconW/DRRMGU3bcBLi5H4pV013OnPkXzadz/xdyMkpl8cMwl3/LsO2FnGB812IfA06x9o4ScJQ7LTFFtov5nn5YPtSv4MPdI/dmP4LrMa7ZZwjaIS6AQ3xjMWM9o1C/J5FXVcQxeAz2GW404Aa6r8pQLvDBeLnqQuU5c+XaNsNHglYL4mUhM9CqsO3PMNr31OaPjnWqRYWjEBJebrV831eF6zvJkw3WDksnVXrnOcns6HE2vvYO2/hAKZRe3DZo1fqehaCaQ1q7bn5JAoGBAPR8cy36sgXTm7FH9n9DlaLGo9tASo8TrJkpwZlpA7ISKyvk2jTkULx3EKfqIoDPjNWIk83E8rkhuoLv4YDE2hQyqopv9xR6sqZpl0Kt19c1uSHHE1jTsmPr3VCf0duwQNYFrS/XDxlT87ZxT7bc1oFR2fzibJJVRE2OJ86OW3wnAoGBAPMztjVmNZtS+iX0sPMSINTey7M2DP1huBPoB/+aXKtWKkFME5Ypzeo4Z+wPsbyk7h/sGJtpobeDw71CjCuC+krCUUswHrRIPFvsW4xKdMw69qZINbu9ZSe64c2VCaWrIGnwAzMlncd6pnah2rb40DxM9QfXoXENnO1dxs1uQwoFAoGBAKnGeh1lx5XwOl/Df1Mk1ZZxpnusi5oLqYG602v61swjfcM/ap/sJHybmf9gwZD9j+kArNLpfzw8Rc6DUe8fw+jevjrgQY4BHmodTSLKoeYasnLYUYEPkQN+WPOR6CNMo9l7m6ZrC1slR0pcKWTsujCXbG8FtStw9rt8ifwQM0tlAoGBAKoF1/eDCi0ZmIoag+6bGNrZG32hZvlpbKB2EclvKCQcbBQUVIkhlrSNVJHi8vYYM+WbUCSud4Ftm9VfhdERk1vad6zh6kVNTu1Q0zvD/d2dxzu+tdoXcXWSIDRyYjkw5stJIWOLg7+mjmPXialrT2EoyBEAffwkcTY83jRWRoXlAoGBAI8NXuUnqU3+o3WVIqEayk1hh0sjiXw4QsmwZ4SNS0vfzKdLQUjtQGMTI51gCFcMUx6q1kZrxl09VR1NDTiExwqAtFidh1UKky/xRp9NqeQHHXt67329WGpO0VU253Grkn/7I9al8J6RchSztl7roe7/kkTbYabYpVF5XbwBl6ch
c51d326a-adb5-482a-8071-1687fbfb860e	d7f31252-c97f-4458-a2d9-e72ba81d5b99	certificate	MIICnzCCAYcCBgFp5tcvSTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhhcGljdXJpbzAeFw0xOTA0MDQwNTMyMzVaFw0yOTA0MDQwNTM0MTVaMBMxETAPBgNVBAMMCGFwaWN1cmlvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6EOEIxBjPb0/2En4WRwK2Cdz6EHyuGk+zeZOd0RcXnjK6Qf4qT7PHJ2rc49/aGEgKZyhHmP1C5s/P/qMXKsRVP8NziBt8y98Bvb+460iuS202fiSr35HDhqFZBX5J1G0R2rHkaVjInPvRccUjuS9yJOPCi8igucea1dCeudlAKp51FvM43oW9nz63qKwo8C3YylRy+wcum6CYyDTYT/QIBbQrcGJUw4DtFYpoA/fuVzcPvT0Dn0gWRnqrmmAogO3U/VxCdh6BkkVhijEClxPYE5syH/6+ePEUT/Pp4owLi00ak+3S2uNGxVjOhLbkjQWVLFrFvccZR80Av8dmtfywwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBiTEYlhjGSaI9uir21ZXtbMlEr2Drm5+sORzLtQSuAhZnW6YUR8x7hF3bEIuMvrXZldc2db8jQ2JZ9ixWaCGLVkuMZrqxRRKB7KJj3+w40NPsOC9qKQHvlYBlKJH6OB+H/CH38slz1329gfQq3muVrQWkmcAB7txJlJ/pUbEPetPNpKWaRTp5NFraJQu5g8iepYn39Z1x8/ws1TpFPOT4qseclXaDfoZlYHrekdR+3SnSSMVXrBxLV8mu6KwDhTOZON9eckPJRT9HHzeFELhs0XlkNuu7lhv/V5IPf1U/y6R83bypXUSVGR9T7dCIT3XmjbotSsyR4IRFpO5hKueYR
5b3a71e9-f1f3-4a1c-87d0-0bdab10bd651	faf59f09-a28e-4966-8f10-4c26cc919d36	priority	100
621bc381-b8f2-4cb3-bfcc-8522e8633b4e	faf59f09-a28e-4966-8f10-4c26cc919d36	secret	JOMUeH23XOTCjuvHAStMt0gxSjOtDlUEyA3EEnU3OlQ
81916a6d-bf1e-4dfd-ad81-def7c98cc70e	faf59f09-a28e-4966-8f10-4c26cc919d36	kid	849bbe2e-73be-43af-9033-629f09b02f77
3aa5f23e-e92a-42e8-8dd1-38b60986bebc	1c64dc8d-3c68-4ce9-ac59-9b477637b198	kid	e9183922-7dec-4b9b-a51f-89af5c70a11e
798ddb6c-51d9-45f1-aee6-d98fa0ce4947	1c64dc8d-3c68-4ce9-ac59-9b477637b198	priority	100
2aa70c39-075b-4d6c-a6ee-06a6aec66a0e	1c64dc8d-3c68-4ce9-ac59-9b477637b198	secret	0m2jwU1BGAFS5Xkra6oHTA
a89afcca-3c1d-43b7-b0ba-174c04ff2181	1d5feae9-2d0e-4d96-b6b7-c593ef91f6fe	allow-default-scopes	true
95dc85d1-898a-4de0-b077-38adf987639b	bf534cae-067d-4316-b5b7-4aeb0947d651	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY composite_role (composite, child_role) FROM stdin;
9d69ff93-e779-49fa-8f09-63b000396f51	7039042b-2512-469f-8d2e-b0bb7a9be9d5
9d69ff93-e779-49fa-8f09-63b000396f51	02015320-4598-45eb-a238-6f7448f545d1
9d69ff93-e779-49fa-8f09-63b000396f51	bdd14c0f-9ff9-4997-9ff9-92be0588647b
9d69ff93-e779-49fa-8f09-63b000396f51	3f729588-ef55-4bef-920c-74e2bfbef083
9d69ff93-e779-49fa-8f09-63b000396f51	e4b0255a-0399-4e42-8402-f8c6f3153ab4
9d69ff93-e779-49fa-8f09-63b000396f51	afed66fc-368b-4c68-bacd-4b19d9166b6d
9d69ff93-e779-49fa-8f09-63b000396f51	820ac790-972a-4f10-916f-8da31afc1448
9d69ff93-e779-49fa-8f09-63b000396f51	c093e64b-cd3b-4371-b7fa-174b3d73c998
9d69ff93-e779-49fa-8f09-63b000396f51	cfd46761-4243-403a-b721-a4293dee61d2
9d69ff93-e779-49fa-8f09-63b000396f51	982f67d3-721a-4632-b46a-27afef3e6f6b
9d69ff93-e779-49fa-8f09-63b000396f51	1241eede-9bbb-48e8-aeb5-d7c31f65af1b
9d69ff93-e779-49fa-8f09-63b000396f51	d7de8476-c167-4293-9ece-0a365bec36c1
9d69ff93-e779-49fa-8f09-63b000396f51	97af48cd-2300-4431-bf57-966d86d473f0
9d69ff93-e779-49fa-8f09-63b000396f51	c1a044d7-5cab-4201-aedb-6ce9fd9ba291
9d69ff93-e779-49fa-8f09-63b000396f51	5023956a-c16b-4833-add3-3448b4fca35f
9d69ff93-e779-49fa-8f09-63b000396f51	5eb9e663-25e3-41ec-8238-1a6c2a6bc026
9d69ff93-e779-49fa-8f09-63b000396f51	2d035fff-cdcd-4eac-8f23-f63431e42dcb
9d69ff93-e779-49fa-8f09-63b000396f51	24dd713a-3b8d-413f-88b8-e69e0406df57
3f729588-ef55-4bef-920c-74e2bfbef083	5023956a-c16b-4833-add3-3448b4fca35f
3f729588-ef55-4bef-920c-74e2bfbef083	24dd713a-3b8d-413f-88b8-e69e0406df57
e4b0255a-0399-4e42-8402-f8c6f3153ab4	5eb9e663-25e3-41ec-8238-1a6c2a6bc026
45382874-db6b-4c3c-97c6-480f68745f7d	a28ee932-69d0-4d13-b11a-263a0134d03f
9d69ff93-e779-49fa-8f09-63b000396f51	5a9dda57-c219-4187-b61b-08d3373901b0
9d69ff93-e779-49fa-8f09-63b000396f51	2acd376f-07d2-47bf-ae82-7e2f2ba4de99
9d69ff93-e779-49fa-8f09-63b000396f51	4cc24a49-bc71-43c9-8fe3-5f1fe73680b0
9d69ff93-e779-49fa-8f09-63b000396f51	e330da0e-76bd-42ae-856d-b4f72e1badda
9d69ff93-e779-49fa-8f09-63b000396f51	fafac4b7-6383-4dae-9944-09c849b42a95
9d69ff93-e779-49fa-8f09-63b000396f51	1877a54a-714d-45a2-8845-8d7e7493a17e
9d69ff93-e779-49fa-8f09-63b000396f51	70067944-77aa-4353-8035-720e46733c86
9d69ff93-e779-49fa-8f09-63b000396f51	2d44f265-539c-443a-9026-ce97dd777622
9d69ff93-e779-49fa-8f09-63b000396f51	da30bbb9-529e-400b-b714-004319c20902
9d69ff93-e779-49fa-8f09-63b000396f51	2b66c834-450b-4d3a-bf5e-fd7f4c0df821
9d69ff93-e779-49fa-8f09-63b000396f51	b77e00e9-5b94-4fb7-8872-9d991b50a05c
9d69ff93-e779-49fa-8f09-63b000396f51	50acccc0-a56f-417f-a35e-558f1983d95c
9d69ff93-e779-49fa-8f09-63b000396f51	25135740-f439-48d8-8d10-4b8065942898
9d69ff93-e779-49fa-8f09-63b000396f51	584c8397-16d4-45e4-b9ee-45f39579db0a
9d69ff93-e779-49fa-8f09-63b000396f51	361fbd67-5ef9-44c1-93b0-40ad54d1c01e
9d69ff93-e779-49fa-8f09-63b000396f51	0595e254-7530-4da2-ac7f-583220180325
9d69ff93-e779-49fa-8f09-63b000396f51	098e023f-cea9-4cca-aa96-f946a8155093
9d69ff93-e779-49fa-8f09-63b000396f51	4740356d-394a-4dc4-a3e5-b7796ec7b177
e330da0e-76bd-42ae-856d-b4f72e1badda	361fbd67-5ef9-44c1-93b0-40ad54d1c01e
e330da0e-76bd-42ae-856d-b4f72e1badda	4740356d-394a-4dc4-a3e5-b7796ec7b177
fafac4b7-6383-4dae-9944-09c849b42a95	0595e254-7530-4da2-ac7f-583220180325
af9c14c0-a4ec-42d0-842d-893b71513e53	bce506e4-ade2-43a2-952c-ac8f38a60136
a352d363-fcaf-4253-92dc-05969bf7d64a	ed3011ee-c042-48d4-a403-7f7cb33a9a2b
a352d363-fcaf-4253-92dc-05969bf7d64a	af9c14c0-a4ec-42d0-842d-893b71513e53
a352d363-fcaf-4253-92dc-05969bf7d64a	8fab0861-5840-4f7a-b0ef-3c153bc7dbe4
a352d363-fcaf-4253-92dc-05969bf7d64a	9b6022b0-a9e4-4b70-a9d0-e55261afbc84
a352d363-fcaf-4253-92dc-05969bf7d64a	832b72a5-9ffe-409f-8743-dd45af30f628
a352d363-fcaf-4253-92dc-05969bf7d64a	c726991d-93cb-4dbb-b21f-6be2843245a5
a352d363-fcaf-4253-92dc-05969bf7d64a	fc8edd3b-28d1-4e29-b1af-c76c6afeed10
a352d363-fcaf-4253-92dc-05969bf7d64a	12471067-1e79-49a0-87b2-a690ac406c5e
a352d363-fcaf-4253-92dc-05969bf7d64a	f398bace-8608-4a5f-b2ce-3a617bb315b5
a352d363-fcaf-4253-92dc-05969bf7d64a	eac3f5d1-e99f-45e5-80bb-38203b361477
a352d363-fcaf-4253-92dc-05969bf7d64a	8e6477ae-3377-4f60-bf3b-ee1c3ac37d32
a352d363-fcaf-4253-92dc-05969bf7d64a	fda86d3a-b35d-4487-8be9-3c2bb207c094
a352d363-fcaf-4253-92dc-05969bf7d64a	8665cae0-de01-4bc4-9469-2635ac730855
a352d363-fcaf-4253-92dc-05969bf7d64a	7c0e5729-90da-4290-8949-7f13aef1a023
a352d363-fcaf-4253-92dc-05969bf7d64a	fcd9238d-6551-4952-bc11-db9c79458817
a352d363-fcaf-4253-92dc-05969bf7d64a	e0ba5ac1-640b-4601-9e54-e8ea947faf86
a352d363-fcaf-4253-92dc-05969bf7d64a	5dfe17ab-7e22-45a0-a535-89a14855c513
a352d363-fcaf-4253-92dc-05969bf7d64a	bce506e4-ade2-43a2-952c-ac8f38a60136
8e6477ae-3377-4f60-bf3b-ee1c3ac37d32	ed3011ee-c042-48d4-a403-7f7cb33a9a2b
8e6477ae-3377-4f60-bf3b-ee1c3ac37d32	fcd9238d-6551-4952-bc11-db9c79458817
976f7bf4-5230-45a0-9e20-d69f9beb6c3e	f5797267-0db0-468d-8265-5574ff29faf6
9d69ff93-e779-49fa-8f09-63b000396f51	68d30f98-f609-4464-8455-e2c5211d529a
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY credential (id, device, hash_iterations, salt, type, value, user_id, created_date, counter, digits, period, algorithm) FROM stdin;
dffd9d87-af94-47da-95a8-6ef36a95bcfb	\N	27500	\\x30689ccd7bdc622d0f89ea726471f55a	password	+ktvDt+NOOXWmy8QdfF34YqfEw0toTFbhHPZFCyYvNYoXmIccpod8poCbfDQCKYvv0YrW0KDWQsEehNaYYbyTA==	7a464a04-90e0-494b-bc47-56f2290f19ff	\N	0	0	0	pbkdf2-sha256
5608fc75-c839-4a3a-90c4-57c068f39fc4	\N	27500	\\x62db46f9857a706f4e0a9f388aabe72a	password	YelZfeSglqVClx4xJdHqs7WSqg4MsG18faqu7bfS4OVNxA+JXIMwyJqU+sZJNsLUnj6fZ60BWp7RUvX1za+Zzw==	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6	1554356722054	0	0	0	pbkdf2-sha256
\.


--
-- Data for Name: credential_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY credential_attribute (id, credential_id, name, value) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2019-04-04 05:34:01.258375	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4356040746
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2019-04-04 05:34:01.268994	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4356040746
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2019-04-04 05:34:01.328614	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	4356040746
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2019-04-04 05:34:01.335576	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4356040746
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2019-04-04 05:34:01.483631	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4356040746
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2019-04-04 05:34:01.488411	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4356040746
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2019-04-04 05:34:01.62125	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4356040746
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2019-04-04 05:34:01.626181	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4356040746
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2019-04-04 05:34:01.635524	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	4356040746
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2019-04-04 05:34:01.797622	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	4356040746
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2019-04-04 05:34:01.90498	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4356040746
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2019-04-04 05:34:01.909057	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4356040746
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2019-04-04 05:34:02.013444	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4356040746
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2019-04-04 05:34:02.067766	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	4356040746
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2019-04-04 05:34:02.071205	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4356040746
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2019-04-04 05:34:02.074533	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	4356040746
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2019-04-04 05:34:02.077845	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	4356040746
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2019-04-04 05:34:02.170166	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	4356040746
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2019-04-04 05:34:02.253268	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4356040746
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2019-04-04 05:34:02.261682	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4356040746
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2019-04-04 05:34:02.941597	45	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	4356040746
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2019-04-04 05:34:02.265465	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4356040746
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2019-04-04 05:34:02.269623	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4356040746
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2019-04-04 05:34:02.309556	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	4356040746
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2019-04-04 05:34:02.318737	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4356040746
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2019-04-04 05:34:02.32213	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4356040746
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2019-04-04 05:34:02.365783	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	4356040746
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2019-04-04 05:34:02.459369	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	4356040746
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2019-04-04 05:34:02.465849	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4356040746
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2019-04-04 05:34:02.549501	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	4356040746
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2019-04-04 05:34:02.570286	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	4356040746
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2019-04-04 05:34:02.599386	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	4356040746
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2019-04-04 05:34:02.607537	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	4356040746
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2019-04-04 05:34:02.617105	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4356040746
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2019-04-04 05:34:02.620651	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4356040746
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2019-04-04 05:34:02.669841	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4356040746
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2019-04-04 05:34:02.698332	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	4356040746
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2019-04-04 05:34:02.707951	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4356040746
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2019-04-04 05:34:02.715724	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	4356040746
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2019-04-04 05:34:02.730414	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	4356040746
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2019-04-04 05:34:02.733708	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4356040746
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2019-04-04 05:34:02.737156	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4356040746
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2019-04-04 05:34:02.905339	42	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	4356040746
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2019-04-04 05:34:02.924541	43	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	4356040746
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2019-04-04 05:34:02.933402	44	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4356040746
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2019-04-04 05:34:02.945108	46	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4356040746
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2019-04-04 05:34:03.004505	47	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	4356040746
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2019-04-04 05:34:03.022429	48	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	4356040746
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2019-04-04 05:34:03.080965	49	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	4356040746
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2019-04-04 05:34:03.124299	50	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	4356040746
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2019-04-04 05:34:03.130985	51	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4356040746
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2019-04-04 05:34:03.137075	52	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	4356040746
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2019-04-04 05:34:03.142962	53	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	4356040746
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2019-04-04 05:34:03.153457	54	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	4356040746
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2019-04-04 05:34:03.160742	55	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	4356040746
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2019-04-04 05:34:03.212531	56	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	4356040746
4.0.0-KEYCLOAK-5579	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2019-04-04 05:34:03.362162	57	EXECUTED	7:c88da39534e99aba51cc89d09fd53936	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	4356040746
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2019-04-04 05:34:03.419784	58	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	4356040746
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2019-04-04 05:34:03.430047	59	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4356040746
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	36285060-103f-4503-8fb7-3fa11fcbf595	f
master	c78f16fe-fc10-450b-84e6-326f1e16ef5a	t
master	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e	t
master	06a182f7-5d41-4292-a816-9265e6403545	t
master	dc579de7-aff9-477f-a915-8870ed197ded	f
master	710b0144-c205-4973-83c8-b55c7c27071b	f
apicurio	202bccce-83ad-4b51-b1cc-03b30767615e	f
apicurio	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2	t
apicurio	a79c4431-e328-4cf2-9d2f-64438ca49cb9	t
apicurio	9e334551-c1ef-4128-89a3-26e26725ac27	t
apicurio	5eff62af-767d-46dd-bf43-5394f39aa356	f
apicurio	a638cf1e-d35d-402b-baa2-0ddbb602bf33	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_credential_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_credential_attribute (id, credential_id, name, value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_credential (id, device, hash_iterations, salt, type, value, created_date, counter, digits, period, algorithm, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
github	apicurio	328571	stuartwdouglas	access_token=6429a79eeeec93adff45fa7cdd559e4dffd7bd59&scope=read%3Aorg%2Crepo%2Cuser%3Aemail&token_type=bearer	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
8c2324be-ae70-41ec-9ed0-c1ec45df8910	t	github	github	t	f	apicurio	t	t	015ed7a5-12db-4292-8e00-fc9ae16d3a51	\N	\N	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY identity_provider_config (identity_provider_id, value, name) FROM stdin;
8c2324be-ae70-41ec-9ed0-c1ec45df8910		hideOnLoginPage
8c2324be-ae70-41ec-9ed0-c1ec45df8910	c73fa5218834188ff756	clientId
8c2324be-ae70-41ec-9ed0-c1ec45df8910		disableUserInfo
8c2324be-ae70-41ec-9ed0-c1ec45df8910	read:org user:email repo	defaultScope
8c2324be-ae70-41ec-9ed0-c1ec45df8910	true	useJwksUrl
8c2324be-ae70-41ec-9ed0-c1ec45df8910	fa0f48d6f5d4a022e922b1829b395b38834502d4	clientSecret
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
9d69ff93-e779-49fa-8f09-63b000396f51	master	f	${role_admin}	admin	master	\N	master
7039042b-2512-469f-8d2e-b0bb7a9be9d5	master	f	${role_create-realm}	create-realm	master	\N	master
02015320-4598-45eb-a238-6f7448f545d1	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_create-client}	create-client	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
bdd14c0f-9ff9-4997-9ff9-92be0588647b	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_view-realm}	view-realm	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
3f729588-ef55-4bef-920c-74e2bfbef083	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_view-users}	view-users	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
e4b0255a-0399-4e42-8402-f8c6f3153ab4	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_view-clients}	view-clients	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
afed66fc-368b-4c68-bacd-4b19d9166b6d	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_view-events}	view-events	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
820ac790-972a-4f10-916f-8da31afc1448	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_view-identity-providers}	view-identity-providers	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
c093e64b-cd3b-4371-b7fa-174b3d73c998	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_view-authorization}	view-authorization	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
cfd46761-4243-403a-b721-a4293dee61d2	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_manage-realm}	manage-realm	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
982f67d3-721a-4632-b46a-27afef3e6f6b	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_manage-users}	manage-users	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
1241eede-9bbb-48e8-aeb5-d7c31f65af1b	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_manage-clients}	manage-clients	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
d7de8476-c167-4293-9ece-0a365bec36c1	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_manage-events}	manage-events	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
97af48cd-2300-4431-bf57-966d86d473f0	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_manage-identity-providers}	manage-identity-providers	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
c1a044d7-5cab-4201-aedb-6ce9fd9ba291	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_manage-authorization}	manage-authorization	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
5023956a-c16b-4833-add3-3448b4fca35f	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_query-users}	query-users	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
5eb9e663-25e3-41ec-8238-1a6c2a6bc026	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_query-clients}	query-clients	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
2d035fff-cdcd-4eac-8f23-f63431e42dcb	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_query-realms}	query-realms	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
24dd713a-3b8d-413f-88b8-e69e0406df57	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_query-groups}	query-groups	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
9d79a9a2-e942-4332-ba3c-c9d9a2db521d	f036cd86-f38d-49d0-83a7-e1babea17489	t	${role_view-profile}	view-profile	master	f036cd86-f38d-49d0-83a7-e1babea17489	\N
45382874-db6b-4c3c-97c6-480f68745f7d	f036cd86-f38d-49d0-83a7-e1babea17489	t	${role_manage-account}	manage-account	master	f036cd86-f38d-49d0-83a7-e1babea17489	\N
a28ee932-69d0-4d13-b11a-263a0134d03f	f036cd86-f38d-49d0-83a7-e1babea17489	t	${role_manage-account-links}	manage-account-links	master	f036cd86-f38d-49d0-83a7-e1babea17489	\N
478ce9ae-1ffb-4ab0-aafb-bef41c747b0a	086db8dd-b7d8-4f56-84bf-7547f233c86d	t	${role_read-token}	read-token	master	086db8dd-b7d8-4f56-84bf-7547f233c86d	\N
5a9dda57-c219-4187-b61b-08d3373901b0	8702814b-4ddc-4ed2-8f07-9185873cc2df	t	${role_impersonation}	impersonation	master	8702814b-4ddc-4ed2-8f07-9185873cc2df	\N
2b2f7770-e203-4e18-bdf6-3485f41362e3	master	f	${role_offline-access}	offline_access	master	\N	master
cfc6b387-459b-4bb0-ae76-b46f2d25bb53	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
2acd376f-07d2-47bf-ae82-7e2f2ba4de99	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_create-client}	create-client	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
4cc24a49-bc71-43c9-8fe3-5f1fe73680b0	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_view-realm}	view-realm	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
e330da0e-76bd-42ae-856d-b4f72e1badda	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_view-users}	view-users	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
fafac4b7-6383-4dae-9944-09c849b42a95	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_view-clients}	view-clients	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
1877a54a-714d-45a2-8845-8d7e7493a17e	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_view-events}	view-events	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
70067944-77aa-4353-8035-720e46733c86	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_view-identity-providers}	view-identity-providers	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
2d44f265-539c-443a-9026-ce97dd777622	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_view-authorization}	view-authorization	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
da30bbb9-529e-400b-b714-004319c20902	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_manage-realm}	manage-realm	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
2b66c834-450b-4d3a-bf5e-fd7f4c0df821	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_manage-users}	manage-users	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
b77e00e9-5b94-4fb7-8872-9d991b50a05c	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_manage-clients}	manage-clients	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
50acccc0-a56f-417f-a35e-558f1983d95c	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_manage-events}	manage-events	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
25135740-f439-48d8-8d10-4b8065942898	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_manage-identity-providers}	manage-identity-providers	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
584c8397-16d4-45e4-b9ee-45f39579db0a	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_manage-authorization}	manage-authorization	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
361fbd67-5ef9-44c1-93b0-40ad54d1c01e	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_query-users}	query-users	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
0595e254-7530-4da2-ac7f-583220180325	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_query-clients}	query-clients	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
098e023f-cea9-4cca-aa96-f946a8155093	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_query-realms}	query-realms	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
4740356d-394a-4dc4-a3e5-b7796ec7b177	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_query-groups}	query-groups	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
4b82c838-4ba2-4263-9147-873f69f1495a	apicurio	f	${role_offline-access}	offline_access	apicurio	\N	apicurio
088b8094-3929-44fb-b0ce-c837a3251ac4	apicurio	f	${role_uma_authorization}	uma_authorization	apicurio	\N	apicurio
ed3011ee-c042-48d4-a403-7f7cb33a9a2b	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_query-users}	query-users	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
af9c14c0-a4ec-42d0-842d-893b71513e53	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_view-clients}	view-clients	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
8fab0861-5840-4f7a-b0ef-3c153bc7dbe4	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_create-client}	create-client	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
a352d363-fcaf-4253-92dc-05969bf7d64a	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_realm-admin}	realm-admin	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
9b6022b0-a9e4-4b70-a9d0-e55261afbc84	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_impersonation}	impersonation	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
832b72a5-9ffe-409f-8743-dd45af30f628	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_view-events}	view-events	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
c726991d-93cb-4dbb-b21f-6be2843245a5	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_view-identity-providers}	view-identity-providers	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
fc8edd3b-28d1-4e29-b1af-c76c6afeed10	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_view-realm}	view-realm	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
12471067-1e79-49a0-87b2-a690ac406c5e	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_view-authorization}	view-authorization	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
f398bace-8608-4a5f-b2ce-3a617bb315b5	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_manage-authorization}	manage-authorization	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
eac3f5d1-e99f-45e5-80bb-38203b361477	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_manage-realm}	manage-realm	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
8e6477ae-3377-4f60-bf3b-ee1c3ac37d32	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_view-users}	view-users	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
fda86d3a-b35d-4487-8be9-3c2bb207c094	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_query-realms}	query-realms	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
8665cae0-de01-4bc4-9469-2635ac730855	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_manage-events}	manage-events	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
7c0e5729-90da-4290-8949-7f13aef1a023	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_manage-clients}	manage-clients	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
fcd9238d-6551-4952-bc11-db9c79458817	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_query-groups}	query-groups	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
e0ba5ac1-640b-4601-9e54-e8ea947faf86	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_manage-identity-providers}	manage-identity-providers	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
5dfe17ab-7e22-45a0-a535-89a14855c513	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_manage-users}	manage-users	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
bce506e4-ade2-43a2-952c-ac8f38a60136	3cc45054-7d22-4926-aa41-de29712997f3	t	${role_query-clients}	query-clients	apicurio	3cc45054-7d22-4926-aa41-de29712997f3	\N
6d5d5080-1541-4acb-8d7f-3fc93f723f56	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	t	${role_read-token}	read-token	apicurio	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
f5797267-0db0-468d-8265-5574ff29faf6	672c1b68-be12-464a-a904-86a7c352d1b9	t	${role_manage-account-links}	manage-account-links	apicurio	672c1b68-be12-464a-a904-86a7c352d1b9	\N
078e7991-5dd9-43e4-af4c-c5aa2a92e21c	672c1b68-be12-464a-a904-86a7c352d1b9	t	${role_view-profile}	view-profile	apicurio	672c1b68-be12-464a-a904-86a7c352d1b9	\N
976f7bf4-5230-45a0-9e20-d69f9beb6c3e	672c1b68-be12-464a-a904-86a7c352d1b9	t	${role_manage-account}	manage-account	apicurio	672c1b68-be12-464a-a904-86a7c352d1b9	\N
68d30f98-f609-4464-8455-e2c5211d529a	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	t	${role_impersonation}	impersonation	master	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY migration_model (id, version) FROM stdin;
SINGLETON	4.0.0
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY offline_user_session (user_session_id, user_id, realm_id, last_session_refresh, offline_flag, data) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
8bd119a1-3216-42ca-ac5d-c20c16885626	locale	openid-connect	oidc-usermodel-attribute-mapper	c15085ea-9ade-4e9e-b867-cc94574dfda1	\N
a7c50df0-b74a-454c-8dc6-6be3b38a4f52	role list	saml	saml-role-list-mapper	\N	c78f16fe-fc10-450b-84e6-326f1e16ef5a
18550332-6061-4493-a5c2-7056a6885084	full name	openid-connect	oidc-full-name-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
3f350180-fbbe-45bb-a331-6824d8f71856	family name	openid-connect	oidc-usermodel-property-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	given name	openid-connect	oidc-usermodel-property-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
e4682963-0ae6-4aac-abb1-083be6a784f4	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
7c571f23-9815-415b-9d30-eb76c10b2afb	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	username	openid-connect	oidc-usermodel-property-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
f25db7ce-4e73-495b-abfa-8220fb268d99	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
39968a71-5d1f-42e2-927d-30ee76fd5000	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
d31361e2-6139-4791-8a26-5f8161b98245	website	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
768e8f39-2be4-4b0a-9df2-04150c345156	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
19b36db6-3a25-47e4-82e2-579af223b8ce	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
5029fa30-8ae4-46e1-a53f-87ad64130aa3	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
59e363c9-8a14-4952-8654-3d5b35e9f366	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	2b6ba3f5-0578-45ed-a575-5a6eeb832d1e
cbf0146a-264c-48c6-a33c-0f73a1d268ce	email	openid-connect	oidc-usermodel-property-mapper	\N	06a182f7-5d41-4292-a816-9265e6403545
278c9f90-a360-4f50-ad69-adc848959089	email verified	openid-connect	oidc-usermodel-property-mapper	\N	06a182f7-5d41-4292-a816-9265e6403545
cd75852e-baba-4b20-8188-98e71b8326c9	address	openid-connect	oidc-address-mapper	\N	dc579de7-aff9-477f-a915-8870ed197ded
ba930390-841a-4ec1-aa03-da247d20d330	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	710b0144-c205-4973-83c8-b55c7c27071b
d5ca01dd-823c-4430-b126-351bd5e4d0b8	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	710b0144-c205-4973-83c8-b55c7c27071b
dffb7ebc-4d47-4c72-8dc3-4c4cbac94321	role list	saml	saml-role-list-mapper	\N	8df50349-f3b5-4ac8-9ffe-b4b90a9c53a2
cb6910c7-1b86-443a-96d1-423b6e77d432	full name	openid-connect	oidc-full-name-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	family name	openid-connect	oidc-usermodel-property-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
b6555dc6-8aa9-40cf-9893-928b72747ae2	given name	openid-connect	oidc-usermodel-property-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
7e8427c5-3773-41f7-9cc1-521f6725e263	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
95f34239-30d2-4bda-8ccb-e2bbc9df6794	username	openid-connect	oidc-usermodel-property-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
cf608347-1546-4e16-aea1-72e13fbb6d76	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
2761d70d-3a47-4628-b8bf-85c1d6f62412	website	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
abeeed4b-0020-4157-98de-ce8c293a26bf	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	a79c4431-e328-4cf2-9d2f-64438ca49cb9
ad5014a0-88b3-442f-8700-f941e2bf398e	email	openid-connect	oidc-usermodel-property-mapper	\N	9e334551-c1ef-4128-89a3-26e26725ac27
cca86dfc-1d03-49ad-8d35-f554171b0fbd	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9e334551-c1ef-4128-89a3-26e26725ac27
52a77222-91b1-40f4-955c-38e665777f1c	address	openid-connect	oidc-address-mapper	\N	5eff62af-767d-46dd-bf43-5394f39aa356
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a638cf1e-d35d-402b-baa2-0ddbb602bf33
a596d4e2-cf3b-4513-af81-378302d49150	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a638cf1e-d35d-402b-baa2-0ddbb602bf33
1c8191d8-784a-4384-a339-e4b62b1a2a32	full name	openid-connect	oidc-full-name-mapper	d00c75ee-f771-41d4-9374-02ee2b60119f	\N
dde135d0-14bc-427b-87a0-37f41f962e24	family name	openid-connect	oidc-usermodel-property-mapper	d00c75ee-f771-41d4-9374-02ee2b60119f	\N
909417a1-548f-4748-9b53-f30ba5bd67c8	given name	openid-connect	oidc-usermodel-property-mapper	d00c75ee-f771-41d4-9374-02ee2b60119f	\N
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	email	openid-connect	oidc-usermodel-property-mapper	d00c75ee-f771-41d4-9374-02ee2b60119f	\N
2694314c-532b-42c3-9d32-8254cd4682d0	username	openid-connect	oidc-usermodel-property-mapper	d00c75ee-f771-41d4-9374-02ee2b60119f	\N
311305d7-1ac1-42ec-bcd0-3f70042f69dd	role list	saml	saml-role-list-mapper	d00c75ee-f771-41d4-9374-02ee2b60119f	\N
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	email	openid-connect	oidc-usermodel-property-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
f056ce1a-8f2c-46c3-aa32-19987a25b641	role list	saml	saml-role-list-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
d55cd256-e657-4555-81b7-72ff4a88259f	given name	openid-connect	oidc-usermodel-property-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
79cf7caa-fb77-49ea-9022-ec87855b7cff	family name	openid-connect	oidc-usermodel-property-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
5d286639-5e1b-4e21-9dca-bb3b55207402	locale	openid-connect	oidc-usermodel-attribute-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	username	openid-connect	oidc-usermodel-property-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
8688ef06-f458-44a8-8bac-5484fe69ec2e	full name	openid-connect	oidc-full-name-mapper	0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	\N
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	email	openid-connect	oidc-usermodel-property-mapper	d2d71b30-cc35-4911-b89b-8ed17811b0c5	\N
b0e0b87b-7e88-48d2-87ff-e9742b9ff45d	role list	saml	saml-role-list-mapper	d2d71b30-cc35-4911-b89b-8ed17811b0c5	\N
d04bf36d-7165-4f96-93dd-cad5f2545f6d	family name	openid-connect	oidc-usermodel-property-mapper	d2d71b30-cc35-4911-b89b-8ed17811b0c5	\N
4301097d-6025-4ced-abaa-4463b12b1673	given name	openid-connect	oidc-usermodel-property-mapper	d2d71b30-cc35-4911-b89b-8ed17811b0c5	\N
9557ec4b-8e66-497a-adcd-5c683afded42	username	openid-connect	oidc-usermodel-property-mapper	d2d71b30-cc35-4911-b89b-8ed17811b0c5	\N
20b37c20-19b0-4418-8bf6-756e9a2eb2fc	full name	openid-connect	oidc-full-name-mapper	d2d71b30-cc35-4911-b89b-8ed17811b0c5	\N
3ea1e915-695d-4fa7-b3ac-2812da5f089b	given name	openid-connect	oidc-usermodel-property-mapper	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
a8c99066-6bad-4a92-b496-e59f887f2b18	family name	openid-connect	oidc-usermodel-property-mapper	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	email	openid-connect	oidc-usermodel-property-mapper	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
a6187350-8bdb-477d-96cf-32ec619ff381	full name	openid-connect	oidc-full-name-mapper	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
6e94c3fe-93ab-474e-a643-19d75e7e5095	username	openid-connect	oidc-usermodel-property-mapper	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
3495f4db-0956-4afa-9c8f-3f9673c3025a	role list	saml	saml-role-list-mapper	b6ebc625-903d-4a5b-b641-2bd9e0b0b8e3	\N
18471e1c-1f5c-47cb-ba2c-71843e073a06	family name	openid-connect	oidc-usermodel-property-mapper	3cc45054-7d22-4926-aa41-de29712997f3	\N
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	username	openid-connect	oidc-usermodel-property-mapper	3cc45054-7d22-4926-aa41-de29712997f3	\N
cdd836d5-fcbd-464b-ab9d-d6d4bce842e4	role list	saml	saml-role-list-mapper	3cc45054-7d22-4926-aa41-de29712997f3	\N
f4562c1a-a412-4656-a67e-7f7f39747380	full name	openid-connect	oidc-full-name-mapper	3cc45054-7d22-4926-aa41-de29712997f3	\N
25e8d7e1-a666-4557-be76-a61184248b1b	given name	openid-connect	oidc-usermodel-property-mapper	3cc45054-7d22-4926-aa41-de29712997f3	\N
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	email	openid-connect	oidc-usermodel-property-mapper	3cc45054-7d22-4926-aa41-de29712997f3	\N
808862c4-ecc6-4863-9fbe-86635dd90d99	email	openid-connect	oidc-usermodel-property-mapper	672c1b68-be12-464a-a904-86a7c352d1b9	\N
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	username	openid-connect	oidc-usermodel-property-mapper	672c1b68-be12-464a-a904-86a7c352d1b9	\N
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	given name	openid-connect	oidc-usermodel-property-mapper	672c1b68-be12-464a-a904-86a7c352d1b9	\N
fbc610ef-8aec-44e4-8f56-bd7b6a7aead9	full name	openid-connect	oidc-full-name-mapper	672c1b68-be12-464a-a904-86a7c352d1b9	\N
c9dcb562-ac81-4db1-892f-f231d51e2955	family name	openid-connect	oidc-usermodel-property-mapper	672c1b68-be12-464a-a904-86a7c352d1b9	\N
70d86a9f-289f-46c0-91ef-f4fa1d49f7bb	role list	saml	saml-role-list-mapper	672c1b68-be12-464a-a904-86a7c352d1b9	\N
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	given name	openid-connect	oidc-usermodel-property-mapper	0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	\N
365ccd00-ad79-4996-826f-69bdaddb1376	full name	openid-connect	oidc-full-name-mapper	0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	\N
379a1517-742d-48a5-be00-ecc32d4d41ca	username	openid-connect	oidc-usermodel-property-mapper	0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	\N
b05a1100-722a-476a-a6ee-69129e86add0	email	openid-connect	oidc-usermodel-property-mapper	0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	\N
d42c629e-5d0f-444a-a596-3cb15cd124eb	family name	openid-connect	oidc-usermodel-property-mapper	0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	\N
0078f63e-beb1-4335-a786-6b0dd1f453bb	role list	saml	saml-role-list-mapper	0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
8bd119a1-3216-42ca-ac5d-c20c16885626	true	userinfo.token.claim
8bd119a1-3216-42ca-ac5d-c20c16885626	locale	user.attribute
8bd119a1-3216-42ca-ac5d-c20c16885626	true	id.token.claim
8bd119a1-3216-42ca-ac5d-c20c16885626	true	access.token.claim
8bd119a1-3216-42ca-ac5d-c20c16885626	locale	claim.name
8bd119a1-3216-42ca-ac5d-c20c16885626	String	jsonType.label
a7c50df0-b74a-454c-8dc6-6be3b38a4f52	false	single
a7c50df0-b74a-454c-8dc6-6be3b38a4f52	Basic	attribute.nameformat
a7c50df0-b74a-454c-8dc6-6be3b38a4f52	Role	attribute.name
18550332-6061-4493-a5c2-7056a6885084	true	userinfo.token.claim
18550332-6061-4493-a5c2-7056a6885084	true	id.token.claim
18550332-6061-4493-a5c2-7056a6885084	true	access.token.claim
3f350180-fbbe-45bb-a331-6824d8f71856	true	userinfo.token.claim
3f350180-fbbe-45bb-a331-6824d8f71856	lastName	user.attribute
3f350180-fbbe-45bb-a331-6824d8f71856	true	id.token.claim
3f350180-fbbe-45bb-a331-6824d8f71856	true	access.token.claim
3f350180-fbbe-45bb-a331-6824d8f71856	family_name	claim.name
3f350180-fbbe-45bb-a331-6824d8f71856	String	jsonType.label
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	true	userinfo.token.claim
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	firstName	user.attribute
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	true	id.token.claim
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	true	access.token.claim
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	given_name	claim.name
54f4fdcb-aa65-42bd-8d0f-d284d4899dda	String	jsonType.label
e4682963-0ae6-4aac-abb1-083be6a784f4	true	userinfo.token.claim
e4682963-0ae6-4aac-abb1-083be6a784f4	middleName	user.attribute
e4682963-0ae6-4aac-abb1-083be6a784f4	true	id.token.claim
e4682963-0ae6-4aac-abb1-083be6a784f4	true	access.token.claim
e4682963-0ae6-4aac-abb1-083be6a784f4	middle_name	claim.name
e4682963-0ae6-4aac-abb1-083be6a784f4	String	jsonType.label
7c571f23-9815-415b-9d30-eb76c10b2afb	true	userinfo.token.claim
7c571f23-9815-415b-9d30-eb76c10b2afb	nickname	user.attribute
7c571f23-9815-415b-9d30-eb76c10b2afb	true	id.token.claim
7c571f23-9815-415b-9d30-eb76c10b2afb	true	access.token.claim
7c571f23-9815-415b-9d30-eb76c10b2afb	nickname	claim.name
7c571f23-9815-415b-9d30-eb76c10b2afb	String	jsonType.label
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	true	userinfo.token.claim
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	username	user.attribute
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	true	id.token.claim
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	true	access.token.claim
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	preferred_username	claim.name
a9a03440-7a8e-4c5a-b84a-7e8e12a62867	String	jsonType.label
f25db7ce-4e73-495b-abfa-8220fb268d99	true	userinfo.token.claim
f25db7ce-4e73-495b-abfa-8220fb268d99	profile	user.attribute
f25db7ce-4e73-495b-abfa-8220fb268d99	true	id.token.claim
f25db7ce-4e73-495b-abfa-8220fb268d99	true	access.token.claim
f25db7ce-4e73-495b-abfa-8220fb268d99	profile	claim.name
f25db7ce-4e73-495b-abfa-8220fb268d99	String	jsonType.label
39968a71-5d1f-42e2-927d-30ee76fd5000	true	userinfo.token.claim
39968a71-5d1f-42e2-927d-30ee76fd5000	picture	user.attribute
39968a71-5d1f-42e2-927d-30ee76fd5000	true	id.token.claim
39968a71-5d1f-42e2-927d-30ee76fd5000	true	access.token.claim
39968a71-5d1f-42e2-927d-30ee76fd5000	picture	claim.name
39968a71-5d1f-42e2-927d-30ee76fd5000	String	jsonType.label
d31361e2-6139-4791-8a26-5f8161b98245	true	userinfo.token.claim
d31361e2-6139-4791-8a26-5f8161b98245	website	user.attribute
d31361e2-6139-4791-8a26-5f8161b98245	true	id.token.claim
d31361e2-6139-4791-8a26-5f8161b98245	true	access.token.claim
d31361e2-6139-4791-8a26-5f8161b98245	website	claim.name
d31361e2-6139-4791-8a26-5f8161b98245	String	jsonType.label
768e8f39-2be4-4b0a-9df2-04150c345156	true	userinfo.token.claim
768e8f39-2be4-4b0a-9df2-04150c345156	gender	user.attribute
768e8f39-2be4-4b0a-9df2-04150c345156	true	id.token.claim
768e8f39-2be4-4b0a-9df2-04150c345156	true	access.token.claim
768e8f39-2be4-4b0a-9df2-04150c345156	gender	claim.name
768e8f39-2be4-4b0a-9df2-04150c345156	String	jsonType.label
19b36db6-3a25-47e4-82e2-579af223b8ce	true	userinfo.token.claim
19b36db6-3a25-47e4-82e2-579af223b8ce	birthdate	user.attribute
19b36db6-3a25-47e4-82e2-579af223b8ce	true	id.token.claim
19b36db6-3a25-47e4-82e2-579af223b8ce	true	access.token.claim
19b36db6-3a25-47e4-82e2-579af223b8ce	birthdate	claim.name
19b36db6-3a25-47e4-82e2-579af223b8ce	String	jsonType.label
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	true	userinfo.token.claim
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	zoneinfo	user.attribute
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	true	id.token.claim
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	true	access.token.claim
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	zoneinfo	claim.name
5dac9e5e-ce71-401c-b9a7-c4b2aa2d7e51	String	jsonType.label
5029fa30-8ae4-46e1-a53f-87ad64130aa3	true	userinfo.token.claim
5029fa30-8ae4-46e1-a53f-87ad64130aa3	locale	user.attribute
5029fa30-8ae4-46e1-a53f-87ad64130aa3	true	id.token.claim
5029fa30-8ae4-46e1-a53f-87ad64130aa3	true	access.token.claim
5029fa30-8ae4-46e1-a53f-87ad64130aa3	locale	claim.name
5029fa30-8ae4-46e1-a53f-87ad64130aa3	String	jsonType.label
59e363c9-8a14-4952-8654-3d5b35e9f366	true	userinfo.token.claim
59e363c9-8a14-4952-8654-3d5b35e9f366	updatedAt	user.attribute
59e363c9-8a14-4952-8654-3d5b35e9f366	true	id.token.claim
59e363c9-8a14-4952-8654-3d5b35e9f366	true	access.token.claim
59e363c9-8a14-4952-8654-3d5b35e9f366	updated_at	claim.name
59e363c9-8a14-4952-8654-3d5b35e9f366	String	jsonType.label
cbf0146a-264c-48c6-a33c-0f73a1d268ce	true	userinfo.token.claim
cbf0146a-264c-48c6-a33c-0f73a1d268ce	email	user.attribute
cbf0146a-264c-48c6-a33c-0f73a1d268ce	true	id.token.claim
cbf0146a-264c-48c6-a33c-0f73a1d268ce	true	access.token.claim
cbf0146a-264c-48c6-a33c-0f73a1d268ce	email	claim.name
cbf0146a-264c-48c6-a33c-0f73a1d268ce	String	jsonType.label
278c9f90-a360-4f50-ad69-adc848959089	true	userinfo.token.claim
278c9f90-a360-4f50-ad69-adc848959089	emailVerified	user.attribute
278c9f90-a360-4f50-ad69-adc848959089	true	id.token.claim
278c9f90-a360-4f50-ad69-adc848959089	true	access.token.claim
278c9f90-a360-4f50-ad69-adc848959089	email_verified	claim.name
278c9f90-a360-4f50-ad69-adc848959089	boolean	jsonType.label
cd75852e-baba-4b20-8188-98e71b8326c9	formatted	user.attribute.formatted
cd75852e-baba-4b20-8188-98e71b8326c9	country	user.attribute.country
cd75852e-baba-4b20-8188-98e71b8326c9	postal_code	user.attribute.postal_code
cd75852e-baba-4b20-8188-98e71b8326c9	true	userinfo.token.claim
cd75852e-baba-4b20-8188-98e71b8326c9	street	user.attribute.street
cd75852e-baba-4b20-8188-98e71b8326c9	true	id.token.claim
cd75852e-baba-4b20-8188-98e71b8326c9	region	user.attribute.region
cd75852e-baba-4b20-8188-98e71b8326c9	true	access.token.claim
cd75852e-baba-4b20-8188-98e71b8326c9	locality	user.attribute.locality
ba930390-841a-4ec1-aa03-da247d20d330	true	userinfo.token.claim
ba930390-841a-4ec1-aa03-da247d20d330	phoneNumber	user.attribute
ba930390-841a-4ec1-aa03-da247d20d330	true	id.token.claim
ba930390-841a-4ec1-aa03-da247d20d330	true	access.token.claim
ba930390-841a-4ec1-aa03-da247d20d330	phone_number	claim.name
ba930390-841a-4ec1-aa03-da247d20d330	String	jsonType.label
d5ca01dd-823c-4430-b126-351bd5e4d0b8	true	userinfo.token.claim
d5ca01dd-823c-4430-b126-351bd5e4d0b8	phoneNumberVerified	user.attribute
d5ca01dd-823c-4430-b126-351bd5e4d0b8	true	id.token.claim
d5ca01dd-823c-4430-b126-351bd5e4d0b8	true	access.token.claim
d5ca01dd-823c-4430-b126-351bd5e4d0b8	phone_number_verified	claim.name
d5ca01dd-823c-4430-b126-351bd5e4d0b8	boolean	jsonType.label
dffb7ebc-4d47-4c72-8dc3-4c4cbac94321	false	single
dffb7ebc-4d47-4c72-8dc3-4c4cbac94321	Basic	attribute.nameformat
dffb7ebc-4d47-4c72-8dc3-4c4cbac94321	Role	attribute.name
cb6910c7-1b86-443a-96d1-423b6e77d432	true	userinfo.token.claim
cb6910c7-1b86-443a-96d1-423b6e77d432	true	id.token.claim
cb6910c7-1b86-443a-96d1-423b6e77d432	true	access.token.claim
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	true	userinfo.token.claim
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	lastName	user.attribute
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	true	id.token.claim
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	true	access.token.claim
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	family_name	claim.name
e43da9d7-1dc8-4390-b17e-e25896bfc5d9	String	jsonType.label
b6555dc6-8aa9-40cf-9893-928b72747ae2	true	userinfo.token.claim
b6555dc6-8aa9-40cf-9893-928b72747ae2	firstName	user.attribute
b6555dc6-8aa9-40cf-9893-928b72747ae2	true	id.token.claim
b6555dc6-8aa9-40cf-9893-928b72747ae2	true	access.token.claim
b6555dc6-8aa9-40cf-9893-928b72747ae2	given_name	claim.name
b6555dc6-8aa9-40cf-9893-928b72747ae2	String	jsonType.label
7e8427c5-3773-41f7-9cc1-521f6725e263	true	userinfo.token.claim
7e8427c5-3773-41f7-9cc1-521f6725e263	middleName	user.attribute
7e8427c5-3773-41f7-9cc1-521f6725e263	true	id.token.claim
7e8427c5-3773-41f7-9cc1-521f6725e263	true	access.token.claim
7e8427c5-3773-41f7-9cc1-521f6725e263	middle_name	claim.name
7e8427c5-3773-41f7-9cc1-521f6725e263	String	jsonType.label
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	true	userinfo.token.claim
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	nickname	user.attribute
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	true	id.token.claim
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	true	access.token.claim
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	nickname	claim.name
ccae8b28-fe2e-44b8-acdd-5f792fefcbbe	String	jsonType.label
95f34239-30d2-4bda-8ccb-e2bbc9df6794	true	userinfo.token.claim
95f34239-30d2-4bda-8ccb-e2bbc9df6794	username	user.attribute
95f34239-30d2-4bda-8ccb-e2bbc9df6794	true	id.token.claim
95f34239-30d2-4bda-8ccb-e2bbc9df6794	true	access.token.claim
95f34239-30d2-4bda-8ccb-e2bbc9df6794	preferred_username	claim.name
95f34239-30d2-4bda-8ccb-e2bbc9df6794	String	jsonType.label
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	true	userinfo.token.claim
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	profile	user.attribute
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	true	id.token.claim
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	true	access.token.claim
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	profile	claim.name
83bd7fb9-0e3a-4560-94ef-20b2a1799d33	String	jsonType.label
cf608347-1546-4e16-aea1-72e13fbb6d76	true	userinfo.token.claim
cf608347-1546-4e16-aea1-72e13fbb6d76	picture	user.attribute
cf608347-1546-4e16-aea1-72e13fbb6d76	true	id.token.claim
cf608347-1546-4e16-aea1-72e13fbb6d76	true	access.token.claim
cf608347-1546-4e16-aea1-72e13fbb6d76	picture	claim.name
cf608347-1546-4e16-aea1-72e13fbb6d76	String	jsonType.label
2761d70d-3a47-4628-b8bf-85c1d6f62412	true	userinfo.token.claim
2761d70d-3a47-4628-b8bf-85c1d6f62412	website	user.attribute
2761d70d-3a47-4628-b8bf-85c1d6f62412	true	id.token.claim
2761d70d-3a47-4628-b8bf-85c1d6f62412	true	access.token.claim
2761d70d-3a47-4628-b8bf-85c1d6f62412	website	claim.name
2761d70d-3a47-4628-b8bf-85c1d6f62412	String	jsonType.label
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	true	userinfo.token.claim
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	gender	user.attribute
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	true	id.token.claim
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	true	access.token.claim
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	gender	claim.name
76058ea3-e8c5-477b-a2e4-a01933f1e9b6	String	jsonType.label
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	true	userinfo.token.claim
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	birthdate	user.attribute
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	true	id.token.claim
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	true	access.token.claim
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	birthdate	claim.name
ed233d6b-15fc-4a79-bee7-67e03e0b94d3	String	jsonType.label
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	true	userinfo.token.claim
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	zoneinfo	user.attribute
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	true	id.token.claim
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	true	access.token.claim
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	zoneinfo	claim.name
bfbe63a4-2ea8-4a73-a9b4-7fb206b79fb9	String	jsonType.label
abeeed4b-0020-4157-98de-ce8c293a26bf	true	userinfo.token.claim
abeeed4b-0020-4157-98de-ce8c293a26bf	locale	user.attribute
abeeed4b-0020-4157-98de-ce8c293a26bf	true	id.token.claim
abeeed4b-0020-4157-98de-ce8c293a26bf	true	access.token.claim
abeeed4b-0020-4157-98de-ce8c293a26bf	locale	claim.name
abeeed4b-0020-4157-98de-ce8c293a26bf	String	jsonType.label
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	true	userinfo.token.claim
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	updatedAt	user.attribute
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	true	id.token.claim
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	true	access.token.claim
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	updated_at	claim.name
c067c2ae-e313-4e1d-bae2-7eb4ad9b51e4	String	jsonType.label
ad5014a0-88b3-442f-8700-f941e2bf398e	true	userinfo.token.claim
ad5014a0-88b3-442f-8700-f941e2bf398e	email	user.attribute
ad5014a0-88b3-442f-8700-f941e2bf398e	true	id.token.claim
ad5014a0-88b3-442f-8700-f941e2bf398e	true	access.token.claim
ad5014a0-88b3-442f-8700-f941e2bf398e	email	claim.name
ad5014a0-88b3-442f-8700-f941e2bf398e	String	jsonType.label
cca86dfc-1d03-49ad-8d35-f554171b0fbd	true	userinfo.token.claim
cca86dfc-1d03-49ad-8d35-f554171b0fbd	emailVerified	user.attribute
cca86dfc-1d03-49ad-8d35-f554171b0fbd	true	id.token.claim
cca86dfc-1d03-49ad-8d35-f554171b0fbd	true	access.token.claim
cca86dfc-1d03-49ad-8d35-f554171b0fbd	email_verified	claim.name
cca86dfc-1d03-49ad-8d35-f554171b0fbd	boolean	jsonType.label
52a77222-91b1-40f4-955c-38e665777f1c	formatted	user.attribute.formatted
52a77222-91b1-40f4-955c-38e665777f1c	country	user.attribute.country
52a77222-91b1-40f4-955c-38e665777f1c	postal_code	user.attribute.postal_code
52a77222-91b1-40f4-955c-38e665777f1c	true	userinfo.token.claim
52a77222-91b1-40f4-955c-38e665777f1c	street	user.attribute.street
52a77222-91b1-40f4-955c-38e665777f1c	true	id.token.claim
52a77222-91b1-40f4-955c-38e665777f1c	region	user.attribute.region
52a77222-91b1-40f4-955c-38e665777f1c	true	access.token.claim
52a77222-91b1-40f4-955c-38e665777f1c	locality	user.attribute.locality
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	true	userinfo.token.claim
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	phoneNumber	user.attribute
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	true	id.token.claim
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	true	access.token.claim
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	phone_number	claim.name
4e5f8d31-3f82-43b9-94fc-45ec0cc07aa8	String	jsonType.label
a596d4e2-cf3b-4513-af81-378302d49150	true	userinfo.token.claim
a596d4e2-cf3b-4513-af81-378302d49150	phoneNumberVerified	user.attribute
a596d4e2-cf3b-4513-af81-378302d49150	true	id.token.claim
a596d4e2-cf3b-4513-af81-378302d49150	true	access.token.claim
a596d4e2-cf3b-4513-af81-378302d49150	phone_number_verified	claim.name
a596d4e2-cf3b-4513-af81-378302d49150	boolean	jsonType.label
1c8191d8-784a-4384-a339-e4b62b1a2a32	true	id.token.claim
1c8191d8-784a-4384-a339-e4b62b1a2a32	true	access.token.claim
1c8191d8-784a-4384-a339-e4b62b1a2a32	true	userinfo.token.claim
dde135d0-14bc-427b-87a0-37f41f962e24	true	userinfo.token.claim
dde135d0-14bc-427b-87a0-37f41f962e24	lastName	user.attribute
dde135d0-14bc-427b-87a0-37f41f962e24	true	id.token.claim
dde135d0-14bc-427b-87a0-37f41f962e24	true	access.token.claim
dde135d0-14bc-427b-87a0-37f41f962e24	family_name	claim.name
dde135d0-14bc-427b-87a0-37f41f962e24	String	jsonType.label
909417a1-548f-4748-9b53-f30ba5bd67c8	true	userinfo.token.claim
909417a1-548f-4748-9b53-f30ba5bd67c8	firstName	user.attribute
909417a1-548f-4748-9b53-f30ba5bd67c8	true	id.token.claim
909417a1-548f-4748-9b53-f30ba5bd67c8	true	access.token.claim
909417a1-548f-4748-9b53-f30ba5bd67c8	given_name	claim.name
909417a1-548f-4748-9b53-f30ba5bd67c8	String	jsonType.label
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	true	userinfo.token.claim
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	email	user.attribute
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	true	id.token.claim
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	true	access.token.claim
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	email	claim.name
a65e3ec4-a5e5-4cbd-908e-fa6f2c5f6b59	String	jsonType.label
2694314c-532b-42c3-9d32-8254cd4682d0	true	userinfo.token.claim
2694314c-532b-42c3-9d32-8254cd4682d0	username	user.attribute
2694314c-532b-42c3-9d32-8254cd4682d0	true	id.token.claim
2694314c-532b-42c3-9d32-8254cd4682d0	true	access.token.claim
2694314c-532b-42c3-9d32-8254cd4682d0	preferred_username	claim.name
2694314c-532b-42c3-9d32-8254cd4682d0	String	jsonType.label
311305d7-1ac1-42ec-bcd0-3f70042f69dd	false	single
311305d7-1ac1-42ec-bcd0-3f70042f69dd	Basic	attribute.nameformat
311305d7-1ac1-42ec-bcd0-3f70042f69dd	Role	attribute.name
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	true	userinfo.token.claim
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	email	user.attribute
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	true	id.token.claim
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	true	access.token.claim
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	email	claim.name
7e877bbb-17ae-45e9-a5f5-53b38e15db5f	String	jsonType.label
f056ce1a-8f2c-46c3-aa32-19987a25b641	false	single
f056ce1a-8f2c-46c3-aa32-19987a25b641	Basic	attribute.nameformat
f056ce1a-8f2c-46c3-aa32-19987a25b641	Role	attribute.name
d55cd256-e657-4555-81b7-72ff4a88259f	true	userinfo.token.claim
d55cd256-e657-4555-81b7-72ff4a88259f	firstName	user.attribute
d55cd256-e657-4555-81b7-72ff4a88259f	true	id.token.claim
d55cd256-e657-4555-81b7-72ff4a88259f	true	access.token.claim
d55cd256-e657-4555-81b7-72ff4a88259f	given_name	claim.name
d55cd256-e657-4555-81b7-72ff4a88259f	String	jsonType.label
79cf7caa-fb77-49ea-9022-ec87855b7cff	true	userinfo.token.claim
79cf7caa-fb77-49ea-9022-ec87855b7cff	lastName	user.attribute
79cf7caa-fb77-49ea-9022-ec87855b7cff	true	id.token.claim
79cf7caa-fb77-49ea-9022-ec87855b7cff	true	access.token.claim
79cf7caa-fb77-49ea-9022-ec87855b7cff	family_name	claim.name
79cf7caa-fb77-49ea-9022-ec87855b7cff	String	jsonType.label
5d286639-5e1b-4e21-9dca-bb3b55207402	true	userinfo.token.claim
5d286639-5e1b-4e21-9dca-bb3b55207402	locale	user.attribute
5d286639-5e1b-4e21-9dca-bb3b55207402	true	id.token.claim
5d286639-5e1b-4e21-9dca-bb3b55207402	true	access.token.claim
5d286639-5e1b-4e21-9dca-bb3b55207402	locale	claim.name
5d286639-5e1b-4e21-9dca-bb3b55207402	String	jsonType.label
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	true	userinfo.token.claim
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	username	user.attribute
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	true	id.token.claim
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	true	access.token.claim
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	preferred_username	claim.name
5cc3f6f3-e97a-4a20-821f-8a32d0d91d25	String	jsonType.label
8688ef06-f458-44a8-8bac-5484fe69ec2e	true	id.token.claim
8688ef06-f458-44a8-8bac-5484fe69ec2e	true	access.token.claim
8688ef06-f458-44a8-8bac-5484fe69ec2e	true	userinfo.token.claim
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	true	userinfo.token.claim
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	email	user.attribute
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	true	id.token.claim
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	true	access.token.claim
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	email	claim.name
a2d2f041-c735-4ba4-a6a8-65ad6dac8d41	String	jsonType.label
b0e0b87b-7e88-48d2-87ff-e9742b9ff45d	false	single
b0e0b87b-7e88-48d2-87ff-e9742b9ff45d	Basic	attribute.nameformat
b0e0b87b-7e88-48d2-87ff-e9742b9ff45d	Role	attribute.name
d04bf36d-7165-4f96-93dd-cad5f2545f6d	true	userinfo.token.claim
d04bf36d-7165-4f96-93dd-cad5f2545f6d	lastName	user.attribute
d04bf36d-7165-4f96-93dd-cad5f2545f6d	true	id.token.claim
d04bf36d-7165-4f96-93dd-cad5f2545f6d	true	access.token.claim
d04bf36d-7165-4f96-93dd-cad5f2545f6d	family_name	claim.name
d04bf36d-7165-4f96-93dd-cad5f2545f6d	String	jsonType.label
4301097d-6025-4ced-abaa-4463b12b1673	true	userinfo.token.claim
4301097d-6025-4ced-abaa-4463b12b1673	firstName	user.attribute
4301097d-6025-4ced-abaa-4463b12b1673	true	id.token.claim
4301097d-6025-4ced-abaa-4463b12b1673	true	access.token.claim
4301097d-6025-4ced-abaa-4463b12b1673	given_name	claim.name
4301097d-6025-4ced-abaa-4463b12b1673	String	jsonType.label
9557ec4b-8e66-497a-adcd-5c683afded42	true	userinfo.token.claim
9557ec4b-8e66-497a-adcd-5c683afded42	username	user.attribute
9557ec4b-8e66-497a-adcd-5c683afded42	true	id.token.claim
9557ec4b-8e66-497a-adcd-5c683afded42	true	access.token.claim
9557ec4b-8e66-497a-adcd-5c683afded42	preferred_username	claim.name
9557ec4b-8e66-497a-adcd-5c683afded42	String	jsonType.label
20b37c20-19b0-4418-8bf6-756e9a2eb2fc	true	id.token.claim
20b37c20-19b0-4418-8bf6-756e9a2eb2fc	true	access.token.claim
20b37c20-19b0-4418-8bf6-756e9a2eb2fc	true	userinfo.token.claim
3ea1e915-695d-4fa7-b3ac-2812da5f089b	true	userinfo.token.claim
3ea1e915-695d-4fa7-b3ac-2812da5f089b	firstName	user.attribute
3ea1e915-695d-4fa7-b3ac-2812da5f089b	true	id.token.claim
3ea1e915-695d-4fa7-b3ac-2812da5f089b	true	access.token.claim
3ea1e915-695d-4fa7-b3ac-2812da5f089b	given_name	claim.name
3ea1e915-695d-4fa7-b3ac-2812da5f089b	String	jsonType.label
a8c99066-6bad-4a92-b496-e59f887f2b18	true	userinfo.token.claim
a8c99066-6bad-4a92-b496-e59f887f2b18	lastName	user.attribute
a8c99066-6bad-4a92-b496-e59f887f2b18	true	id.token.claim
a8c99066-6bad-4a92-b496-e59f887f2b18	true	access.token.claim
a8c99066-6bad-4a92-b496-e59f887f2b18	family_name	claim.name
a8c99066-6bad-4a92-b496-e59f887f2b18	String	jsonType.label
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	true	userinfo.token.claim
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	email	user.attribute
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	true	id.token.claim
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	true	access.token.claim
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	email	claim.name
4bf5f6f3-9c45-4b82-92a2-b992d3df079a	String	jsonType.label
a6187350-8bdb-477d-96cf-32ec619ff381	true	id.token.claim
a6187350-8bdb-477d-96cf-32ec619ff381	true	access.token.claim
a6187350-8bdb-477d-96cf-32ec619ff381	true	userinfo.token.claim
6e94c3fe-93ab-474e-a643-19d75e7e5095	true	userinfo.token.claim
6e94c3fe-93ab-474e-a643-19d75e7e5095	username	user.attribute
6e94c3fe-93ab-474e-a643-19d75e7e5095	true	id.token.claim
6e94c3fe-93ab-474e-a643-19d75e7e5095	true	access.token.claim
6e94c3fe-93ab-474e-a643-19d75e7e5095	preferred_username	claim.name
6e94c3fe-93ab-474e-a643-19d75e7e5095	String	jsonType.label
3495f4db-0956-4afa-9c8f-3f9673c3025a	false	single
3495f4db-0956-4afa-9c8f-3f9673c3025a	Basic	attribute.nameformat
3495f4db-0956-4afa-9c8f-3f9673c3025a	Role	attribute.name
18471e1c-1f5c-47cb-ba2c-71843e073a06	true	userinfo.token.claim
18471e1c-1f5c-47cb-ba2c-71843e073a06	lastName	user.attribute
18471e1c-1f5c-47cb-ba2c-71843e073a06	true	id.token.claim
18471e1c-1f5c-47cb-ba2c-71843e073a06	true	access.token.claim
18471e1c-1f5c-47cb-ba2c-71843e073a06	family_name	claim.name
18471e1c-1f5c-47cb-ba2c-71843e073a06	String	jsonType.label
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	true	userinfo.token.claim
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	username	user.attribute
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	true	id.token.claim
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	true	access.token.claim
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	preferred_username	claim.name
f7ac9dbb-c665-442f-b04e-8d27d8d9242a	String	jsonType.label
cdd836d5-fcbd-464b-ab9d-d6d4bce842e4	false	single
cdd836d5-fcbd-464b-ab9d-d6d4bce842e4	Basic	attribute.nameformat
cdd836d5-fcbd-464b-ab9d-d6d4bce842e4	Role	attribute.name
f4562c1a-a412-4656-a67e-7f7f39747380	true	id.token.claim
f4562c1a-a412-4656-a67e-7f7f39747380	true	access.token.claim
f4562c1a-a412-4656-a67e-7f7f39747380	true	userinfo.token.claim
25e8d7e1-a666-4557-be76-a61184248b1b	true	userinfo.token.claim
25e8d7e1-a666-4557-be76-a61184248b1b	firstName	user.attribute
25e8d7e1-a666-4557-be76-a61184248b1b	true	id.token.claim
25e8d7e1-a666-4557-be76-a61184248b1b	true	access.token.claim
25e8d7e1-a666-4557-be76-a61184248b1b	given_name	claim.name
25e8d7e1-a666-4557-be76-a61184248b1b	String	jsonType.label
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	true	userinfo.token.claim
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	email	user.attribute
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	true	id.token.claim
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	true	access.token.claim
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	email	claim.name
0ed13d35-7fa6-4dc8-b8c0-2890d06940cf	String	jsonType.label
808862c4-ecc6-4863-9fbe-86635dd90d99	true	userinfo.token.claim
808862c4-ecc6-4863-9fbe-86635dd90d99	email	user.attribute
808862c4-ecc6-4863-9fbe-86635dd90d99	true	id.token.claim
808862c4-ecc6-4863-9fbe-86635dd90d99	true	access.token.claim
808862c4-ecc6-4863-9fbe-86635dd90d99	email	claim.name
808862c4-ecc6-4863-9fbe-86635dd90d99	String	jsonType.label
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	true	userinfo.token.claim
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	username	user.attribute
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	true	id.token.claim
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	true	access.token.claim
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	preferred_username	claim.name
08eed7cc-1d63-4c8f-a577-1d9ec0c6ae15	String	jsonType.label
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	true	userinfo.token.claim
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	firstName	user.attribute
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	true	id.token.claim
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	true	access.token.claim
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	given_name	claim.name
f1fb13d4-455f-4a28-b2ee-7e93fff315dd	String	jsonType.label
fbc610ef-8aec-44e4-8f56-bd7b6a7aead9	true	id.token.claim
fbc610ef-8aec-44e4-8f56-bd7b6a7aead9	true	access.token.claim
fbc610ef-8aec-44e4-8f56-bd7b6a7aead9	true	userinfo.token.claim
c9dcb562-ac81-4db1-892f-f231d51e2955	true	userinfo.token.claim
c9dcb562-ac81-4db1-892f-f231d51e2955	lastName	user.attribute
c9dcb562-ac81-4db1-892f-f231d51e2955	true	id.token.claim
c9dcb562-ac81-4db1-892f-f231d51e2955	true	access.token.claim
c9dcb562-ac81-4db1-892f-f231d51e2955	family_name	claim.name
c9dcb562-ac81-4db1-892f-f231d51e2955	String	jsonType.label
70d86a9f-289f-46c0-91ef-f4fa1d49f7bb	false	single
70d86a9f-289f-46c0-91ef-f4fa1d49f7bb	Basic	attribute.nameformat
70d86a9f-289f-46c0-91ef-f4fa1d49f7bb	Role	attribute.name
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	true	userinfo.token.claim
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	firstName	user.attribute
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	true	id.token.claim
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	true	access.token.claim
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	given_name	claim.name
fff0d4ba-8021-4b63-9db1-9f239f9aee0e	String	jsonType.label
365ccd00-ad79-4996-826f-69bdaddb1376	true	id.token.claim
365ccd00-ad79-4996-826f-69bdaddb1376	true	access.token.claim
365ccd00-ad79-4996-826f-69bdaddb1376	true	userinfo.token.claim
379a1517-742d-48a5-be00-ecc32d4d41ca	true	userinfo.token.claim
379a1517-742d-48a5-be00-ecc32d4d41ca	username	user.attribute
379a1517-742d-48a5-be00-ecc32d4d41ca	true	id.token.claim
379a1517-742d-48a5-be00-ecc32d4d41ca	true	access.token.claim
379a1517-742d-48a5-be00-ecc32d4d41ca	preferred_username	claim.name
379a1517-742d-48a5-be00-ecc32d4d41ca	String	jsonType.label
b05a1100-722a-476a-a6ee-69129e86add0	true	userinfo.token.claim
b05a1100-722a-476a-a6ee-69129e86add0	email	user.attribute
b05a1100-722a-476a-a6ee-69129e86add0	true	id.token.claim
b05a1100-722a-476a-a6ee-69129e86add0	true	access.token.claim
b05a1100-722a-476a-a6ee-69129e86add0	email	claim.name
b05a1100-722a-476a-a6ee-69129e86add0	String	jsonType.label
d42c629e-5d0f-444a-a596-3cb15cd124eb	true	userinfo.token.claim
d42c629e-5d0f-444a-a596-3cb15cd124eb	lastName	user.attribute
d42c629e-5d0f-444a-a596-3cb15cd124eb	true	id.token.claim
d42c629e-5d0f-444a-a596-3cb15cd124eb	true	access.token.claim
d42c629e-5d0f-444a-a596-3cb15cd124eb	family_name	claim.name
d42c629e-5d0f-444a-a596-3cb15cd124eb	String	jsonType.label
0078f63e-beb1-4335-a786-6b0dd1f453bb	false	single
0078f63e-beb1-4335-a786-6b0dd1f453bb	Basic	attribute.nameformat
0078f63e-beb1-4335-a786-6b0dd1f453bb	Role	attribute.name
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	8702814b-4ddc-4ed2-8f07-9185873cc2df	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	14fc0101-93a1-4fb8-907a-baf3e1f2bc67	815317d3-6f71-4635-baa3-897884ecb30b	89e8f4ad-7681-41eb-bf3e-c781136c8060	0db8d7cc-6902-448c-9f99-03ce25ca6d37	f86ec19b-9b2d-4426-9ae3-ecde3c7722e6	2592000	f	900	t	f	4b83895d-3c3f-46d5-8f47-5f9be44477b8	0	f
apicurio	60	300	300	\N	\N	\N	t	f	0	apicurio	apicurio	0	\N	t	t	f	f	NONE	1800	36000	f	f	94e4d3b9-5e4e-4f7f-92d2-68d1b01fe40c	1800	f	\N	t	f	f	f	0	1	30	6	HmacSHA1	totp	c460ce37-c909-4652-b384-b1db6946080d	8ce2b483-3dd8-428f-957b-42fd343d7350	57e0ec37-7e1b-4c6f-b04f-58c240b350fa	3b6b9062-33d4-40f2-8edd-8aae8dc5fbcc	04b52715-4a24-4f1e-87e3-057ad4411023	2592000	f	900	t	f	91423aca-8bc1-4e10-9e4c-f7ab44db13e2	0	f
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
_browser_header.xContentTypeOptions	nosniff	apicurio
_browser_header.xRobotsTag	none	apicurio
_browser_header.xFrameOptions	SAMEORIGIN	apicurio
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	apicurio
_browser_header.xXSSProtection	1; mode=block	apicurio
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	apicurio
bruteForceProtected	false	apicurio
permanentLockout	false	apicurio
maxFailureWaitSeconds	900	apicurio
minimumQuickLoginWaitSeconds	60	apicurio
waitIncrementSeconds	60	apicurio
quickLoginCheckMilliSeconds	1000	apicurio
maxDeltaTimeSeconds	43200	apicurio
failureFactor	30	apicurio
offlineSessionMaxLifespanEnabled	false	apicurio
offlineSessionMaxLifespan	5184000	apicurio
actionTokenGeneratedByAdminLifespan	43200	apicurio
actionTokenGeneratedByUserLifespan	300	apicurio
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_default_roles (realm_id, role_id) FROM stdin;
master	2b2f7770-e203-4e18-bdf6-3485f41362e3
master	cfc6b387-459b-4bb0-ae76-b46f2d25bb53
apicurio	4b82c838-4ba2-4263-9147-873f69f1495a
apicurio	088b8094-3929-44fb-b0ce-c837a3251ac4
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
apicurio	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	apicurio
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY realm_supported_locales (realm_id, value) FROM stdin;
apicurio	
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY redirect_uris (client_id, value) FROM stdin;
f036cd86-f38d-49d0-83a7-e1babea17489	/auth/realms/master/account/*
c15085ea-9ade-4e9e-b867-cc94574dfda1	/auth/admin/master/console/*
0a6fe8b8-b357-4fa8-b0a4-253a08e4f8e2	/auth/admin/apicurio/console/*
672c1b68-be12-464a-a904-86a7c352d1b9	/auth/realms/apicurio/account/*
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	https://apicurio-studio.apps.dev.openshift.redhatkeynote.com/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id) FROM stdin;
cb5dba23-a9e1-4270-a38e-2a1ac49b2e62	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL
53366ea4-d207-4553-b2b1-6da5f5696b47	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE
276f407f-9d4c-4dcf-9b79-05b58d04193d	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP
347195c2-4707-43f4-b182-5df30c1b9f58	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD
fc0ac1c0-f642-4046-af2d-051b4004a95b	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions
5d9db527-dd4d-4507-a8f7-2a743592ea6a	CONFIGURE_TOTP	Configure OTP	apicurio	t	f	CONFIGURE_TOTP
24aece8b-617b-48d6-be24-f708d06bc035	UPDATE_PASSWORD	Update Password	apicurio	t	f	UPDATE_PASSWORD
028f5996-fe3c-4456-8e1b-d06a7864991d	UPDATE_PROFILE	Update Profile	apicurio	t	f	UPDATE_PROFILE
f8b394cb-f4e9-4970-a802-cd8677ce87f3	VERIFY_EMAIL	Verify Email	apicurio	t	f	VERIFY_EMAIL
412139fb-09a8-4b71-8f4b-0e1df94f433e	terms_and_conditions	Terms and Conditions	apicurio	f	f	terms_and_conditions
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_server_resource (id, name, uri, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY scope_mapping (client_id, role_id) FROM stdin;
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: session_uuids; Type: TABLE DATA; Schema: public; Owner: -
--

COPY session_uuids (uuid, design_id, user_id, secret, version, expires_on) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
7a464a04-90e0-494b-bc47-56f2290f19ff	\N	30ef884f-2829-46ce-8508-36aa388c58bd	f	t	\N	\N	\N	master	admin	1554356056181	\N	0
cd6c9fe9-460f-48e6-91b2-f48c70f69ac6	stuart.w.douglas@gmail.com	stuart.w.douglas@gmail.com	f	t	\N	Stuart	Douglas	apicurio	stuart.w.douglas@gmail.com	1554356721855	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_role_mapping (role_id, user_id) FROM stdin;
45382874-db6b-4c3c-97c6-480f68745f7d	7a464a04-90e0-494b-bc47-56f2290f19ff
2b2f7770-e203-4e18-bdf6-3485f41362e3	7a464a04-90e0-494b-bc47-56f2290f19ff
9d79a9a2-e942-4332-ba3c-c9d9a2db521d	7a464a04-90e0-494b-bc47-56f2290f19ff
cfc6b387-459b-4bb0-ae76-b46f2d25bb53	7a464a04-90e0-494b-bc47-56f2290f19ff
9d69ff93-e779-49fa-8f09-63b000396f51	7a464a04-90e0-494b-bc47-56f2290f19ff
088b8094-3929-44fb-b0ce-c837a3251ac4	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6
4b82c838-4ba2-4263-9147-873f69f1495a	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6
078e7991-5dd9-43e4-af4c-c5aa2a92e21c	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6
976f7bf4-5230-45a0-9e20-d69f9beb6c3e	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6
6d5d5080-1541-4acb-8d7f-3fc93f723f56	cd6c9fe9-460f-48e6-91b2-f48c70f69ac6
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY web_origins (client_id, value) FROM stdin;
0ca69b5c-7f5b-4f16-b8ba-cdca66eca9e1	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (user_id, type);


--
-- Name: acl_invites acl_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acl_invites
    ADD CONSTRAINT acl_invites_pkey PRIMARY KEY (invite_id);


--
-- Name: acl acl_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acl
    ADD CONSTRAINT acl_pkey PRIMARY KEY (user_id, design_id);


--
-- Name: api_content api_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_content
    ADD CONSTRAINT api_content_pkey PRIMARY KEY (design_id, version);


--
-- Name: api_designs api_designs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_designs
    ADD CONSTRAINT api_designs_pkey PRIMARY KEY (id);


--
-- Name: apicurio apicurio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apicurio
    ADD CONSTRAINT apicurio_pkey PRIMARY KEY (prop_name);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: codegen codegen_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY codegen
    ADD CONSTRAINT codegen_pkey PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: credential_attribute constraint_credential_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT constraint_credential_attr PRIMARY KEY (id);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: fed_credential_attribute constraint_fed_credential_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT constraint_fed_credential_attr PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: session_uuids session_uuids_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY session_uuids
    ADD CONSTRAINT session_uuids_pkey PRIMARY KEY (uuid);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_accounts_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_accounts_1 ON public.accounts USING btree (user_id);


--
-- Name: idx_acl_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_acl_1 ON public.acl USING btree (role);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_codegen_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_codegen_1 ON public.codegen USING btree (ptype);


--
-- Name: idx_codegen_2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_codegen_2 ON public.codegen USING btree (design_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_content_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_content_1 ON public.api_content USING btree (version);


--
-- Name: idx_content_2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_content_2 ON public.api_content USING btree (type);


--
-- Name: idx_content_3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_content_3 ON public.api_content USING btree (created_by);


--
-- Name: idx_content_4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_content_4 ON public.api_content USING btree (created_on);


--
-- Name: idx_content_5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_content_5 ON public.api_content USING btree (reverted);


--
-- Name: idx_credential_attr_cred; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_credential_attr_cred ON public.credential_attribute USING btree (credential_id);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_fed_cred_attr_cred; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fed_cred_attr_cred ON public.fed_credential_attribute USING btree (credential_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_invites_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_invites_1 ON public.acl_invites USING btree (status);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_uuids_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_uuids_1 ON public.session_uuids USING btree (uuid, design_id, secret);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak_role(id);


--
-- Name: acl fk_acl_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acl
    ADD CONSTRAINT fk_acl_1 FOREIGN KEY (design_id) REFERENCES api_designs(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: codegen fk_codegen_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY codegen
    ADD CONSTRAINT fk_codegen_1 FOREIGN KEY (design_id) REFERENCES api_designs(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: api_content fk_content_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_content
    ADD CONSTRAINT fk_content_1 FOREIGN KEY (design_id) REFERENCES api_designs(id);


--
-- Name: credential_attribute fk_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT fk_cred_attr FOREIGN KEY (credential_id) REFERENCES credential(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: fed_credential_attribute fk_fed_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT fk_fed_cred_attr FOREIGN KEY (credential_id) REFERENCES fed_user_credential(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES identity_provider_mapper(id);


--
-- Name: acl_invites fk_invites_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY acl_invites
    ADD CONSTRAINT fk_invites_1 FOREIGN KEY (design_id) REFERENCES api_designs(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

