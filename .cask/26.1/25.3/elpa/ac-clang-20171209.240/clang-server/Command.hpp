/* -*- mode: c++ ; coding: utf-8-unix -*- */
/*  last updated : 2017/11/09.11:02:59 */

/*
 * Copyright (c) 2013-2017 yaruopooner [https://github.com/yaruopooner]
 *
 * This file is part of ac-clang.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


#pragma once

#ifndef __COMMAND_HPP__
#define __COMMAND_HPP__




/*================================================================================================*/
/*  Include Files                                                                                 */
/*================================================================================================*/

#include <memory>
#include <string>

#include "DataObject.hpp"



/*================================================================================================*/
/*  Class                                                                                         */
/*================================================================================================*/


class ICommand : public IMultiSerializable
{
protected:
    ICommand( void ) = default;
    virtual ~ICommand( void ) override = default;

public:
    virtual bool Evaluate( void )
    {
        return true;
    }

protected:
    bool                m_EvaluationResults = false;
    std::ostringstream  m_Error;
};



class CommandContext : public IMultiSerializable
{
public:
    CommandContext( void ) = default;
    virtual ~CommandContext( void ) override = default;

    void AllocateDataObject( IDataObject::EType _InputType, IDataObject::EType _OutputType );

    IDataObject* GetInputDataObject( void )
    {
        return m_Input.get();
    }
    const IDataObject* GetInputDataObject( void ) const
    {
        return m_Input.get();
    }

    IDataObject* GetOutputDataObject( void )
    {
        return m_Output.get();
    }
    const IDataObject* GetOutputDataObject( void ) const
    {
        return m_Output.get();
    }

    void SetInputData( const uint8_t* _Data );
    std::string GetOutputData( void ) const;

    void Clear( void );

    uint32_t GetRequestId( void ) const
    {
        return m_RequestId;
    }
    const std::string& GetCommandType( void ) const
    {
        return m_CommandType;
    }
    const std::string& GetCommandName( void ) const
    {
        return m_CommandName;
    }
    const std::string& GetSessionName( void ) const
    {
        return m_SessionName;
    }
    bool IsProfile( void ) const
    {
        return m_IsProfile;
    }

private:
    virtual void Read( const Lisp::Text::Object& _InData ) override;
    virtual void Read( const Lisp::Node::Object& _InData ) override;
    virtual void Read( const Json& _InData ) override;

    virtual void Write( Lisp::Text::Object& _OutData ) const override;
    virtual void Write( Json& _OutData ) const override;

private:
    std::shared_ptr< IDataObject >  m_Input;
    std::shared_ptr< IDataObject >  m_Output;
    // basic informations
    uint32_t                        m_RequestId = 0;
    std::string                     m_CommandType;
    std::string                     m_CommandName;
    std::string                     m_SessionName;
    bool                            m_IsProfile = false;
};


template< typename SerializableObject >
class Serializer
{
public:
    template< typename Argument >
    Serializer( Argument& _Argument, CommandContext& _Context ) : 
        m_Context( _Context )
        , m_Object( _Argument )
    {
        IDataObject*  data_object = m_Context.GetOutputDataObject();

        data_object->Encode( m_Object );
    }


    CommandContext&     m_Context;
    SerializableObject  m_Object;
};


template< typename SerializableObject >
class Deserializer
{
public:
    template< typename Argument >
    Deserializer( Argument& _Argument, CommandContext& _Context ) : 
        m_Context( _Context )
        , m_Object( _Argument )
    {
        const IDataObject*  data_object = m_Context.GetInputDataObject();

        data_object->Decode( m_Object );
    }


    CommandContext&     m_Context;
    SerializableObject  m_Object;
};


template< typename Command >
class CommandEvaluator
{
public:
    template< typename CommandArgument >
    CommandEvaluator( CommandArgument& _Argument, CommandContext& _Context ) : 
        m_Context( _Context )
        , m_Command( _Argument )
    {
        const IDataObject*  data_object = m_Context.GetInputDataObject();

        data_object->Decode( m_Command );

        m_Command.Evaluate();
    }

    // CommandEvaluator( ClangSession& _Argument, CommandContext& _Context, std::function< bool (Command&) > _CustomEvaluator = std::mem_fn( &Command::Evaluate ) ) : 
    //     m_Context( _Context )
    //     , m_Command( _Argument )
    // {
    //     IDataObject*  data_object = m_Context.GetInputDataObject();

    //     data_object->Decode( m_Command );

    //     // m_Command.Evaluate();
    //     _CustomEvaluator( m_Command );
    // }

    ~CommandEvaluator( void )
    {
        IDataObject*  data_object = m_Context.GetOutputDataObject();

        data_object->Encode( m_Command );
    }

    CommandContext&     m_Context;
    Command             m_Command;
};






#endif  // __COMMAND_HPP__
/*================================================================================================*/
/*  EOF                                                                                           */
/*================================================================================================*/
