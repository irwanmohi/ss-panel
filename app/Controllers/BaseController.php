<?php

namespace App\Controllers;

use App\Services\Auth;
use App\Services\Factory;
use App\Services\View;

/**
 * BaseController
 */
class BaseController
{

    protected $view;

    protected $smarty;

    protected $app;

    /**
     * @var \Illuminate\Translation\Translator
     */
    protected $lang;
    
    
    public function __construct()
    {
        $this->lang = Factory::getLang();
    }

    /**
     * @return \Illuminate\Translation\Translator
     */
    protected function getLang()
    {
        return Factory::getLang();
    }


    /**
     * @return \Smarty
     */
    public function smarty()
    {
        $this->smarty = View::getSmarty();
        return $this->smarty;
    }

    /**
     * @return \Smarty
     */
    public function view()
    {
        return $this->smarty();
    }

    /**
     * @param $response
     * @param $res
     * @param int $statusCode
     * @return mixed
     */
    public function echoJson($response, $res, $statusCode = 200)
    {
        $newResponse = $response->withJson($res, $statusCode);
        return $newResponse;
    }

    /**
     * @param $response
     * @param $to
     * @return mixed
     */
    public function redirect($response, $to)
    {
        $newResponse = $response->withStatus(302)->withHeader('Location', $to);
        return $newResponse;
    }
}